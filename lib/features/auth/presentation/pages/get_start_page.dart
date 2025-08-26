import 'package:flutter/material.dart';
import 'package:safarni/features/auth/presentation/pages/sign_in.dart';
import 'package:safarni/features/auth/presentation/pages/sign_up.dart';
import '../widget/button.dart';


class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});
  static const routeName = '/getStart-screen';
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.08,
        ),
        child: Column(
          children: [
            SizedBox(height: height * 0.15),


            Image.asset(
              "assets/images/logo.png",
              height: height * 0.20,
            ),

            SizedBox(height: height * 0.03),



            SizedBox(height: height * 0.02),


        Text(
          "Wlcome",
        style: TextStyle(
        fontSize: width * 0.06,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
            Text(
              "Safarni is your all-in-one travel guide. Discover new destinations, plan your trips and save your favorite journeys easily.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.045,
                color: Colors.black54,
              ),
            ),


            SizedBox(height: height * 0.08),

            CustomButton(
              text: "Sign Up",
              onPressed: () {
                Navigator.pushNamed(context, SignUpPage.routeName);
              },
            ),

            SizedBox(height: height * 0.015),


            CustomButton(
              text: "Log In",
              onPressed: () {
                Navigator.pushNamed(context, SignInPage.routeName);
              },
              isPrimary: false,
            ),

            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }
}
