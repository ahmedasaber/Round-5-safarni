import '../../domain/entities/payment_intent.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasource/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<PaymentIntentEntity> createPaymentIntent(int amount) async {
    return await remoteDataSource.createPaymentIntent(amount);
  }
}
