import '../../domain/entities/payment_intent.dart';

class PaymentIntentModel extends PaymentIntentEntity {
  PaymentIntentModel({required super.clientSecret});

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      clientSecret: json['clientSecret'],
    );
  }

  Map<String, dynamic> toJson() => {
    'clientSecret': clientSecret,
  };
}
