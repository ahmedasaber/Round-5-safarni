import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';
import 'verify_code.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});
  static const routeName = '/forgetPassword-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final emailController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                // ✅ تمرير الإيميل للصفحة التالية
                Navigator.pushNamed(
                  context,
                  VerifyCodePage.routeName,
                  arguments: emailController.text.trim(), // مهم جداً
                );
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم إرسال رمز التحقق")),
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
                  SizedBox(height: height * 0.08),
                  Image.asset("assets/images/key.png"),
                  SizedBox(height: height * 0.05),
                  Text(
                    "Forget the Password",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    "Please enter your email to reset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: height * 0.05),

                  CustomTextField(
                    hint: "Email",
                    controller: emailController,
                  ),

                  SizedBox(height: height * 0.05),

                  CustomButton(
                    text: state is AuthLoading ? "Loading..." : "Reset Password",
                    onPressed: () {
                      final email = emailController.text.trim();
                      
                      if (email.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("يرجى إدخال البريد الإلكتروني")),
                        );
                        return;
                      }
                      
                      context.read<AuthCubit>().forgotPassword(email);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}