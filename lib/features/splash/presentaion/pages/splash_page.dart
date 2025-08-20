import 'package:flutter/material.dart';

import '../../../onboarding/presentation/pages/onboarding_page.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const routeName = '/splash-screen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
          () async {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) {
              return OnboardingPage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(child:
        Container(
            height:double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/Splash Screen (1).png"),))
            ,child :Text("")
        ) ,
        )

    );
  }
}
