import 'package:dio/dio.dart';
import 'package:safarni/core/helpers/token_manger.dart';
import 'package:safarni/core/services/profile_api_service.dart';
import '../models/profile_user_model.dart';
import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiService _apiService;

  ProfileRemoteDataSourceImpl({required ProfileApiService apiService})
    : _apiService = apiService;

  @override
  Future<ProfileUserModel> getUserProfile() async {
    try {
      final response = await _apiService.getUserProfile();

      if (response['status'] == true && response['data'] != null) {
        final data = response['data'];
        final userData = data['user']; 
        final combinedData = Map<String, dynamic>.from(userData);
        if (data['stats'] != null) {
          combinedData['stats'] = data['stats'];
        }

        return ProfileUserModel.fromJson(combinedData);
      } else {
        throw Exception(response['message'] ?? 'Failed to get profile');
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<ProfileUserModel> updateUserProfile(
    ProfileUpdateRequest request,
  ) async {
    try {
      final response = await _apiService.updateUserProfile(request.toJson());

      if (response['status'] == true && response['data'] != null) {
        final data = response['data'];
        final userData = data['user']; 

        // Combine user data with stats for the model
        final combinedData = Map<String, dynamic>.from(userData);
        if (data['stats'] != null) {
          combinedData['stats'] = data['stats'];
        }

        return ProfileUserModel.fromJson(combinedData);
      } else {
        throw Exception(response['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        newPasswordConfirmation: confirmPassword,
      );

      if (response['status'] != true) {
        throw Exception(response['message'] ?? 'Failed to change password');
      }
    } catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final response = await _apiService.deleteAccount();

      if (response['status'] != true) {
        throw Exception(response['message'] ?? 'Failed to delete account');
      }
      
      // Clear tokens after successful account deletion
      await TokenManager.clearTokens();
    } catch (e) {
      // Clear tokens even if the API call fails for security
      try {
        await TokenManager.clearTokens();
      } catch (tokenError) {
        // Ignore token clearing errors
      }
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await _apiService.logout();
      
      // Clear tokens regardless of API response
      await TokenManager.clearTokens();

      if (response['status'] != true) {
        throw Exception(response['message'] ?? 'Failed to logout');
      }
    } catch (e) {
      // Always clear tokens during logout, even if API fails
      try {
        await TokenManager.clearTokens();
      } catch (tokenError) {
        // Ignore token clearing errors
      }
      
      // For logout, we might want to succeed even if API fails
      // since the important thing is clearing local tokens
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('Connection Time Out');
        
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final responseData = error.response?.data;

          if (statusCode == 401) {
            return Exception('The Session has expired. Please log in again.');
          } else if (statusCode == 403) {
            return Exception('You Don\'t have permission to perform this action.');
          } else if (statusCode == 404) {
            return Exception('The requested resource was not found.');
          } else if (statusCode == 422) {
            // Handle validation errors
            if (responseData is Map && responseData.containsKey('errors')) {
              final errors = responseData['errors'] as Map<String, dynamic>;
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                return Exception(firstError.first.toString());
              }
            }
            return Exception('Invalid request data.');
          } else if (statusCode == 500) {
            return Exception('Internal Server Error.');
          }

          // Try to get message from response
          if (responseData is Map && responseData.containsKey('message')) {
            return Exception(responseData['message'].toString());
          }

          return Exception('Unexpected Error');
          
        case DioExceptionType.cancel:
          return Exception('Request was cancelled.');
          
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') == true) {
            return Exception('No internet connection.');
          }
          return Exception('Network error: ${error.message ?? 'Unknown error'}');
          
        default:
          return Exception('Unknown error: ${error.message ?? 'Something went wrong'}');
      }
    }

    if (error is Exception) {
      return error;
    }

    return Exception(error.toString());
  }
}