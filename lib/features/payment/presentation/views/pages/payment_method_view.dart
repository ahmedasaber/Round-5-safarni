import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:safarni/features/payment/presentation/cubit/payment_state.dart';
import 'package:safarni/features/payment/presentation/views/pages/success_payment_view.dart';

import '../../../../../core/common/widgets/appbar.dart';
import '../../../../../core/common/widgets/elevated_button.dart';
import '../../../../../core/common/widgets/payment_chip.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';
import '../widgets/payment_header_container.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});
  static const routeName = '/payment_method';

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  String? selectedMethod;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomizedAppBar(
          showBackArrow: true,
          centerTitle: true,
          title: const Text(
            "Payment Method",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              Navigator.of(context).pushReplacementNamed(
                SuccessPaymentView.routeName,
              );
            } else if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ Payment failed: ${state.message}")),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add Your\nPayment Method",
                        style: TextStyle(
                          fontSize: TextStyles.fontSizeLg + 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      const PaymentHeaderContainer(),
                      const SizedBox(height: 30),

                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => selectedMethod = "Paypal"),
                              child: PaymentChip(
                                asset: AppAssets.paypal,
                                title: "Paypal",
                                isSelected: selectedMethod == "Paypal",
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () => setState(() => selectedMethod = "Mastercard"),
                              child: PaymentChip(
                                asset: AppAssets.mastercard,
                                title: "Mastercard",
                                isSelected: selectedMethod == "Mastercard",
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () => setState(() => selectedMethod = "Visa"),
                              child: PaymentChip(
                                asset: AppAssets.visa,
                                title: "Visa",
                                isSelected: selectedMethod == "Visa",
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (selectedMethod != null) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                          value == null || value.isEmpty ? "Name is required" : null,
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Your Email",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Email is required";
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) return "Enter a valid email";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        if (selectedMethod == "Mastercard" || selectedMethod == "Visa") ...[
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: TextFormField(
                                  controller: _dateController,
                                  decoration: const InputDecoration(
                                    labelText: "Valid Date",
                                    hintText: "MM/YY",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                  value == null || value.isEmpty ? "Date required" : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: _cvvController,
                                  decoration: const InputDecoration(
                                    labelText: "CVV",
                                    hintText: "3 digits",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return "CVV required";
                                    if (value.length != 3) return "Must be 3 digits";
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],

                      SizedBox(height: selectedMethod == "Paypal" ? 90 : 34),

                      SizedBox(
                        width: double.infinity,
                        child: AppElevatedButton(
                          buttonTitle: state is PaymentLoading
                              ? "Processing..."
                              : selectedMethod == null
                              ? "Continue"
                              : "Confirm Booking",
                          primaryButton: true,
                          onPressed: state is PaymentLoading
                              ? null
                              : () {
                            if (selectedMethod != null &&
                                _formKey.currentState!.validate()) {
                              context
                                  .read<PaymentCubit>()
                                  .payWithMethod(selectedMethod!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a payment method"),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
