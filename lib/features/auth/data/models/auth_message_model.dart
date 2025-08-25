import 'package:safarni/features/auth/domain/entities/auth_message_entity.dart';

class AuthMessageModel extends AuthMessage {
  AuthMessageModel({
    required int status,
    required super.message,
  }) : super(
    success: status == 200 || status == 201,
  );

  factory AuthMessageModel.fromJson(Map<String, dynamic> json) {
    return AuthMessageModel(
      status: json['status'],
      message: json['message'],
    );
  }
}