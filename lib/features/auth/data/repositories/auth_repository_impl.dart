import '../../domain/entities/auth_message_entity.dart';
import '../../domain/entities/otp_entity.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';
import '../models/auth_message_model.dart';
import '../models/otp_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    UserModel model = await remoteDataSource.login(email, password);
    return model;
  }

  @override
  Future<User> register(RegisterRequest request) async {
    UserModel model = await remoteDataSource.register(request);
    return model;
  }

  @override
  Future<AuthMessage> forgotPassword(String email) async {
    AuthMessageModel model = await remoteDataSource.forgotPassword(email);
    return model;
  }

  @override
  Future<AuthMessage> updatePassword(String email, String newPassword) async {
    AuthMessageModel model = await remoteDataSource.updatePassword(email, newPassword);
    return model;
  }

  @override
  Future<Otp> verifyOtp(String email, String otp) async {
    OtpModel model = await remoteDataSource.verifyOtp(email, otp);
    return model;
  }
}
