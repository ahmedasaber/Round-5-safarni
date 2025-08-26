import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';
import 'password_reset_success.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});
  static const routeName = '/ResetPassword-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final email = ModalRoute.of(context)!.settings.arguments as String; // جاي من VerifyCodePage
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

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
              Navigator.pushNamed(context, SuccessPage.routeName);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: height * 0.03),
                Image.asset("assets/images/lock-closed.png"),
                SizedBox(height: height * 0.03),
                Text(
                  "Set New Password",
                  style: TextStyle(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.02),

                Text(
                  "Your new password must be different from previously used passwords.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: height * 0.05),

                CustomTextField(
                  hint: "New Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: height * 0.02),

                CustomTextField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController,
                  obscureText: true,
                ),

                SizedBox(height: height * 0.02),

                Row(
                  children: [
                    Image.asset("assets/images/check-circle.png", height: 20, width: 20),
                    const SizedBox(width: 5),
                    const Text("Must be at least 8 characters"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset("assets/images/check-circle.png", height: 20, width: 20),
                    const SizedBox(width: 5),
                    const Text("Must contain one special character"),
                  ],
                ),

                SizedBox(height: height * 0.04),

                CustomButton(
                  text: state is AuthLoading ? "Saving..." : "Save",
                  onPressed: () {
                    final password = passwordController.text.trim();
                    final confirmPassword = confirmPasswordController.text.trim();

                    if (password.isEmpty || confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    context.read<AuthCubit>().updatePassword(email, password);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
