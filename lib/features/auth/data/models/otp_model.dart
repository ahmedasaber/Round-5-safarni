
import '../../domain/entities/otp_entity.dart';

class OtpModel extends Otp {
  OtpModel({required super.email, required super.verified});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      email: json['email'] ?? '',
      verified: json['verified'] ?? false,
    );
  }
}
