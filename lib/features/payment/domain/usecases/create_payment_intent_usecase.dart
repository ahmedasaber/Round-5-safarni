import '../entities/payment_intent.dart';
import '../repositories/payment_repository.dart';

class CreatePaymentIntentUseCase {
  final PaymentRepository repository;

  CreatePaymentIntentUseCase(this.repository);

  Future<PaymentIntentEntity> call(int amount) async {
    return await repository.createPaymentIntent(amount);
  }
}
