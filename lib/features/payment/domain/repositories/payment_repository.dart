import '../entities/payment_intent.dart';

abstract class PaymentRepository {
  Future<PaymentIntentEntity> createPaymentIntent(int amount);
}
