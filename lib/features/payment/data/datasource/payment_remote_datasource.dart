import 'package:dio/dio.dart';
import '../models/payment_intent_model.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentIntentModel> createPaymentIntent(int amount);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  PaymentRemoteDataSourceImpl(this.dio, {required this.baseUrl});

  @override
  Future<PaymentIntentModel> createPaymentIntent(int amount) async {
    final response = await dio.post(
      "$baseUrl/create-payment-intent.php",
      data: {'amount': amount.toString()},
    );

    if (response.statusCode == 200) {
      return PaymentIntentModel.fromJson(response.data);
    } else {
      throw Exception("Failed to create PaymentIntent");
    }
  }
}
