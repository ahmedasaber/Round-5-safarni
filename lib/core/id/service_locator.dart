import 'package:dio/dio.dart';
import '../../features/auth/data/models/auth_message_model.dart';
import '../../features/auth/data/models/otp_model.dart';
import '../../features/auth/data/models/user_model.dart';
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String name, String email, String password);
  Future<AuthMessageModel> forgotPassword(String email);
  Future<AuthMessageModel> updatePassword(String email, String newPassword);
  Future<OtpModel> verifyOtp(String email, String otp);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> signIn(String email, String password) async {
    final response = await dio.post(
      "https://round5-safarnia.digital-vision-solutions.com/api/login",
      data: {"email": email, "password": password},
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    final response = await dio.post(
      "https://round5-safarnia.digital-vision-solutions.com/api/register",
      data: {"name": name, "email": email, "password": password},
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<AuthMessageModel> forgotPassword(String email) async {
    final response = await dio.post(
      "https://round5-safarnia.digital-vision-solutions.com/api/forgot-password",
      data: {"email": email},
    );
    return AuthMessageModel.fromJson(response.data);
  }

  @override
  Future<AuthMessageModel> updatePassword(String email, String newPassword) async {
    final response = await dio.post(
      "https://round5-safarnia.digital-vision-solutions.com/api/update-password",
      data: {"email": email, "password": newPassword},
    );
    return AuthMessageModel.fromJson(response.data);
  }

  @override
  Future<OtpModel> verifyOtp(String email, String otp) async {
    final response = await dio.post(
      "https://round5-safarnia.digital-vision-solutions.com/api/otp",
      data: {"email": email, "otp": otp},
    );
    return OtpModel.fromJson(response.data);
  }
}
