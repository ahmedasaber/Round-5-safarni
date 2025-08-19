import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../widget/button.dart';
import '../widget/custom_text_field.dart';


import '../../../home/presentation/views/pages/home_view.dart';
import '../../presentaion/pages/sign_in.dart';
import '../widget/social_media_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static const routeName = '/signUp-screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.08),


            SizedBox(height: height * 0.02),

            Center(
              child: Column(
                children: [
                  Text(
                    "Welcome Again",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "welcome back! please Fill Your data",
                    style: TextStyle(
                      fontSize: width * 0.04,

                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.05),

            CustomTextField(hint: "Name", controller: nameController),
            SizedBox(height: height * 0.02),
            CustomTextField(hint: "Email", controller: emailController),
            SizedBox(height: height * 0.02),
            CustomTextField(
              hint: "Password",
              controller: passwordController,
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
,

            SizedBox(height: height * 0.03),
            CustomButton(
              text: "Sign Up",
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeView.routeName,
                      (route) => false,
                );
              },
            ),

            SizedBox(height: height * 0.03),

            SocialAuthButtons(),

            const Spacer(),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignInPage.routeName);
                },
                child: const Text("Already have an account? Sign In"),
              ),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
