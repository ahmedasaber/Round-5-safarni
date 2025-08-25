import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/auth/domain/usecases/register_usecase.dart';
import 'package:safarni/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:safarni/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:safarni/features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../data/models/register_reques.dart';
import '../../domain/entities/auth_message_entity.dart';
import '../../domain/usecases/login_user.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgotPasswordUseCase,
    required this.updatePasswordUseCase,
    required this.verifyOtpUseCase,
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email, password);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register(String name, String email, String password, String confirmPassword) async {
    emit(AuthLoading());
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      final user = await registerUseCase(request);
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      final message = await forgotPasswordUseCase(email);
      emit(AuthSuccess(message: message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> updatePassword(String email, String newPassword) async {
    emit(AuthLoading());
    try {
      final message = await updatePasswordUseCase(email, newPassword);
      emit(AuthSuccess(message: message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(AuthLoading());
    try {
      final result = await verifyOtpUseCase(email, otp);
      emit(AuthSuccess(otp: result));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resendOtp(String email) async {
    emit(AuthLoading());
    try {
      emit(AuthSuccess(
        message: AuthMessage(message: "OTP resent successfully to $email", success: true),
      ));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
