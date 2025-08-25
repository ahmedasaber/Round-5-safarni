import 'package:dio/dio.dart';
import '../models/register_reques.dart';
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
  static const String _base = 'https://round5-safarnia.huma-volve.com/api/';

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
          contentType: Headers.formUrlEncodedContentType, // ✅ لازم
        ),
      );
      return UserModel.fromJson(res.data['data']);
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
          contentType: Headers.formUrlEncodedContentType, // ✅ لازم
        ),
      );
      return UserModel.fromJson(response.data['data']);
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
          contentType: Headers.formUrlEncodedContentType, // ✅ لازم
        ),
      );
      return AuthMessageModel.fromJson(res.data);
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
          contentType: Headers.formUrlEncodedContentType, // ✅ لازم
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
          contentType: Headers.formUrlEncodedContentType, // ✅ لازم
        ),
      );
      return OtpModel.fromJson(res.data);
    } catch (e) {
      throw Exception("Verify OTP failed: $e");
    }
  }
}
