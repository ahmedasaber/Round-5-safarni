// features/profile/data/datasources/profile_remote_data_source.dart


import 'package:dio/dio.dart';
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
      final userData = data['user']; // Extract user data from nested structure
      
      // Combine user data with stats for the model
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
Future<ProfileUserModel> updateUserProfile(ProfileUpdateRequest request) async {
  try {
    final response = await _apiService.updateUserProfile(request.toJson());
    
    if (response['status'] == true && response['data'] != null) {
      final data = response['data'];
      final userData = data['user']; // Extract user data from nested structure
      
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
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception('انتهت مهلة الاتصال. تحقق من اتصالك بالإنترنت.');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final responseData = error.response?.data;
          
          if (statusCode == 401) {
            return Exception('انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.');
          } else if (statusCode == 403) {
            return Exception('ليس لديك صلاحية للوصول إلى هذا المورد.');
          } else if (statusCode == 404) {
            return Exception('المورد المطلوب غير موجود.');
          } else if (statusCode == 422) {
            // Handle validation errors
            if (responseData is Map && responseData.containsKey('errors')) {
              final errors = responseData['errors'] as Map<String, dynamic>;
              final firstError = errors.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                return Exception(firstError.first.toString());
              }
            }
            return Exception('البيانات المدخلة غير صحيحة.');
          } else if (statusCode == 500) {
            return Exception('خطأ في الخادم. يرجى المحاولة مرة أخرى لاحقاً.');
          }
          
          // Try to get message from response
          if (responseData is Map && responseData.containsKey('message')) {
            return Exception(responseData['message'].toString());
          }
          
          return Exception('حدث خطأ غير متوقع.');
        case DioExceptionType.cancel:
          return Exception('تم إلغاء الطلب.');
        case DioExceptionType.unknown:
          return Exception('لا يوجد اتصال بالإنترنت.');
        default:
          return Exception('حدث خطأ غير متوقع.');
      }
    }
    
    if (error is Exception) {
      return error;
    }
    
    return Exception(error.toString());
  }
}