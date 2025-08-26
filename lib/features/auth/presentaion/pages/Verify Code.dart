import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../home/presentation/views/pages/home_view.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widget/button.dart';
import 'Reset Password.dart';
class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({super.key});
  static const routeName = '/verifyCode-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    // جايب الايميل من arguments اللي اتبعت من ForgetPasswordPage
    final email = ModalRoute.of(context)!.settings.arguments as String;

    // controllers for 4 digit code
    final controllers = List.generate(4, (_) => TextEditingController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamed(
                context,
                ResetPasswordPage.routeName,
                arguments: email, // عشان نكمل بالـ email
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: height * 0.05),
                Image.asset("assets/images/envelope.png"),
                SizedBox(height: height * 0.03),
                Text(
                  "Verify Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.050,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  "Enter the 4-digit code sent to your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.05),

                // OTP inputs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                        (index) => SizedBox(
                      width: width * 0.15,
                      child: TextField(
                        controller: controllers[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: height * 0.05),

                CustomButton(
                  text: state is AuthLoading ? "Loading..." : "Verify",
                  onPressed: () {
                    final code = controllers.map((c) => c.text).join();
                    if (code.length == 4) {
                      context.read<AuthCubit>().verifyOtp(email, code);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter full 4-digit code")),
                      );
                    }
                  },
                ),

                SizedBox(height: height * 0.03),

                TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().resendOtp(email);
                  },
                  child: const Text("Resend Code"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
