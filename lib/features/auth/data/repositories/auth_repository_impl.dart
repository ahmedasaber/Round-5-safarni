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
    final res = await dio.post(
      '$_base/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(res.data['data']);
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    final response = await dio.post('$_base/register', data: request.toJson());
    return UserModel.fromJson(response.data['data']);
  }

  @override
  Future<AuthMessageModel> forgotPassword(String email) async {
    final res = await dio.post(
      '$_base/forgot-password',
      data: {'email': email},
    );
    return AuthMessageModel.fromJson(res.data);
  }

  @override
  Future<AuthMessageModel> updatePassword(
    String email,
    String newPassword,
  ) async {
    final res = await dio.post(
      '$_base/update-password',
      data: {'email': email, 'password': newPassword},
    );
    return AuthMessageModel.fromJson(res.data);
  }

  @override
  Future<OtpModel> verifyOtp(String email, String otp) async {
    final res = await dio.post(
      '$_base/otp',
      data: {'email': email, 'otp': otp},
    );
    return OtpModel.fromJson(res.data);
  }
}
