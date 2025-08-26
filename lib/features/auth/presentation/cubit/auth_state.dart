import 'package:equatable/equatable.dart';
import 'package:safarni/features/auth/domain/entities/user.dart';

import '../../domain/entities/auth_message_entity.dart';
import '../../domain/entities/otp_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User? user;
  final AuthMessage? message;
  final Otp? otp;

  AuthSuccess({this.user, this.message, this.otp});

  @override
  List<Object?> get props => [user ?? '', message ?? '', otp ?? ''];
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

