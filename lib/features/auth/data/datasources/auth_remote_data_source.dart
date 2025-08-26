import 'package:dio/dio.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';
import '../models/auth_message_model.dart';
import '../models/otp_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(RegisterRequest request);
  Future<AuthMessageModel> forgotPassword(String email);
  Future<AuthMessageModel> updatePassword(String email, String newPassword);
  Future<OtpModel> verifyOtp(String email, String otp);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  static const String _base = 'https://round5-safarnia.huma-volve.com/api';

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      
      final res = await dio.post(
        '$_base/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      
      if (res.data != null) {
        Map<String, dynamic> userData;
        
        if (res.data['data'] != null) {
          userData = res.data['data'];
        } else {
          userData = res.data;
        }
        
        if (res.data['token'] != null && userData['token'] == null) {
          userData['token'] = res.data['token'];
        }
        
        return UserModel.fromJson(userData);
      } else {
        throw Exception("No data received from server");
      }
    } on DioException catch (e) {
      
      if (e.response?.statusCode == 401) {
        throw Exception("Email or password is incorrect");
      } else if (e.response?.statusCode == 422) {
        throw Exception("Ensure email and password are valid");
      } else {
        throw Exception("Login failed");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    try {
      
      final response = await dio.post(
        '$_base/register',
        data: request.toJson(),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

    
      Map<String, dynamic> userData;
      
      if (response.data['data'] != null) {
        userData = response.data['data'];
      } else {
        userData = response.data;
      }
      
      if (response.data['token'] != null && userData['token'] == null) {
        userData['token'] = response.data['token'];
      }
      
      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      
      if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null) {
          String errorMessage = '';
          errors.forEach((key, value) {
            if (value is List) {
              errorMessage += '${value.first}\n';
            }
          });
          throw Exception(errorMessage.trim());
        } else {
          throw Exception("Ensure email and password are valid");
        }
      } else {
        throw Exception("Register failed");
      }
    } catch (e) {
      throw Exception("Register failed: $e");
    }
  }

  @override
  Future<AuthMessageModel> forgotPassword(String email) async {
    try {
      
      final res = await dio.post(
        '$_base/forgot-password',
        data: {
          'email': email,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return AuthMessageModel.fromJson(res.data);
    } on DioException catch (e) {
      
      if (e.response?.statusCode == 404) {
        throw Exception("Email not found");
      } else {
        throw Exception("Forgot password failed");
      }
    } catch (e) {
      throw Exception("Forgot password failed: $e");
    }
  }

  @override
  Future<AuthMessageModel> updatePassword(String email, String newPassword) async {
    try {
      final res = await dio.post(
        '$_base/update-password',
        data: {
          'email': email,
          'password': newPassword,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return AuthMessageModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Update password failed: $e");
    }
  }

  @override
  Future<OtpModel> verifyOtp(String email, String otp) async {
    try {
      
      final res = await dio.post(
        '$_base/otp',
        data: {
          'email': email,
          'otp': otp,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return OtpModel.fromJson(res.data);
    } on DioException catch (e) {
      
      if (e.response?.statusCode == 400) {
        throw Exception("OTP code is invalid");
      } else {
        throw Exception("Verify OTP failed");
      }
    } catch (e) {
      throw Exception("Verify OTP failed: $e");
    }
  }
}