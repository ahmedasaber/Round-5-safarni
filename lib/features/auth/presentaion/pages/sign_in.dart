import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';


import '../../../home/presentation/views/pages/home_view.dart';
import '../../presentaion/pages/forget_password.dart';
import '../../presentaion/pages/sign_up.dart';
import '../widget/social_media_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static const routeName = '/signIn-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.08),

            // Logo
            Center(
              child: Image.asset("assets/images/llll.png",
                  height: height * 0.12),
            ),
            SizedBox(height: height * 0.02),

            Center(
              child: Text(
                "Welcome Again",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: height * 0.05),

            CustomTextField(hint: "Email", controller: emailController),
            SizedBox(height: height * 0.02),
            CustomTextField(
              hint: "Password",
              controller: passwordController,
              obscureText: true,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgetPasswordPage.routeName);
                },
                child: const Text("Forgot Password?"),
              ),
            ),

            CustomButton(
              text: "Sign In",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeView.routeName,
                      (route) => false,
                );
              },
            ),

            SizedBox(height: height * 0.03),

            // Social Buttons
            SocialAuthButtons(),

            const Spacer(),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.routeName);
                },
                child: const Text("DON'T HAVE AN ACCOUNT? SIGN UP"),
              ),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
