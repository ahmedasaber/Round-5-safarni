import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import 'button.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        CustomButton(
          text: "Sign in with Google",
          onPressed: () {},
          isPrimary: false,
          prefixIcon: Image.asset(
            "assets/images/googl.png",
            height: 24,
            width: 24,
          ),
        ),
        SizedBox(height: height * 0.015),
        CustomButton(
          text: "Sign in with Facebook",
          onPressed: () {},
          isPrimary: false,
          prefixIcon: Image.asset(
            "assets/images/facebook.png",
            height: 24,
            width: 24,
          ),
        ),
        SizedBox(height: height * 0.015),
        CustomButton(
          text: "Sign in with Apple",
          onPressed: () {},
          isPrimary: false,
          prefixIcon: Image.asset(
            "assets/images/apple.png",
            height: 24,
            width: 24,
          ),
        ),
      ],
    );
  }
}
