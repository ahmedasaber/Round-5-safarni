import 'package:flutter/material.dart';
import 'package:safarni/features/auth/presentation/pages/sign_in.dart';
import '../widget/button.dart';


class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});
  static const routeName = '/Success-screen';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ SizedBox(height: height * 0.15),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: width * 0.1,
            ),

            SizedBox(height: height * 0.02),

            Text(
              "Password Reset",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: height * 0.02),

            Text(
              "Your password has been changed successfully.\nYou can now log in with your new password.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.035,
                color: Colors.black54,
              ),
            ),

            SizedBox(height: height * 0.06),

            CustomButton(
              text: "Login",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInPage.routeName,
                      (route) => false,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
