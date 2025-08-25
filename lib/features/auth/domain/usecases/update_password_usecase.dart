
import '../entities/auth_message_entity.dart';
import '../repositories/auth_repository.dart';

class UpdatePasswordUseCase {
  final AuthRepository repository;
  UpdatePasswordUseCase(this.repository);

  Future<AuthMessage> call(String email, String newPassword) {
    return repository.updatePassword(email, newPassword);
  }
}
