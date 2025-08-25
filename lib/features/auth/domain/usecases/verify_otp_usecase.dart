
import '../entities/otp_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<Otp> call(String email, String otp) {
    return repository.verifyOtp(email, otp);
  }
}
