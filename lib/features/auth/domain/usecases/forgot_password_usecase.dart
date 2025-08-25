
import '../entities/auth_message_entity.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;
  ForgotPasswordUseCase(this.repository);

  Future<AuthMessage> call(String email) {
    return repository.forgotPassword(email);
  }
}
