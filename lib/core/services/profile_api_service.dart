import 'package:dio/dio.dart';
import 'package:safarni/core/helpers/constants.dart';

class ProfileApiService {
  final Dio _dio;

  ProfileApiService(this._dio);

  // Get user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _dio.get(ApiConstants.getUserProfile);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Update user profile
  Future<Map<String, dynamic>> updateUserProfile(
    Map<String, dynamic> profileData,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.updateUserProfile,
        data: profileData,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }


  // Change password
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.changePassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // Delete account
  Future<Map<String, dynamic>> deleteAccount() async {
    try {
      final response = await _dio.delete(ApiConstants.deleteAccount);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}