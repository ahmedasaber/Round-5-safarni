import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/custom_button.dart';

import '../../../home/presentation/views/pages/home_view.dart';
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

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: Column(
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
            ),   SizedBox(height: height * 0.03),
            Text(
              "Enter the 4-digit code sent to your email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: height * 0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                    (index) => SizedBox(
                  width: width * 0.15,
                  child: TextField(
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
              text: "Verify",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ResetPasswordPage.routeName,
                );
              },
            ),

            SizedBox(height: height * 0.03),

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeView.routeName);
              },
              child: const Text("Resend Code"),
            )
          ],
        ),
      ),
    );
  }
}
