import 'package:flutter/material.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';
import 'Password Reset Success.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});
  static const routeName = '/ResetPassword-screen';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

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
        child: Column(
          children: [
            SizedBox(height: height * 0.03),
Image.asset("assets/images/lock-closed.png"),
            SizedBox(height: height * 0.03),
            Text(
                "Set Naw Password",
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,)),SizedBox(height: height * 0.02),

            Text(
              "Your New Password Must be Different to Previously Used Password",
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
            Row(children: [
              Image.asset("assets/images/check-circle.png"
                ,height: 20,width: 20,),
              Text("Must be at least 8 characters")],)
            ,
            Row(children: [
              Image.asset("assets/images/check-circle.png",height: 20,width: 20,),
              Text("Must contain one special character")],)
            , SizedBox(height: height * 0.02),
            CustomButton(
              text: "Save",
              onPressed: () {
                Navigator.pushNamed(context, SuccessPage.routeName);
              },
            ),

          ],
        ),
      ),
    );
  }
}
