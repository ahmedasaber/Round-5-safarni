

import '../../data/models/register_request.dart';
import '../entities/auth_message_entity.dart';
import '../entities/otp_entity.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(RegisterRequest request);
  Future<AuthMessage> forgotPassword(String email);
  Future<AuthMessage> updatePassword(String email, String newPassword);
  Future<Otp> verifyOtp(String email, String otp);
}
