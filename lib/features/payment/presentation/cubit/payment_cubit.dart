import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial()) {
    // 👇 هنا بتحط الـ publishable key بتاع Stripe
    Stripe.publishableKey = "";
    // Stripe Dashboard → Developers → API Keys
  }

  Future<void> payWithMethod(String method) async {
    emit(PaymentLoading());

    try {
      await Future.delayed(const Duration(seconds: 2)); // mock API call

      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
