import '../../data/models/register_reques.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call(RegisterRequest request) {
    return repository.register(request);
  }
}
