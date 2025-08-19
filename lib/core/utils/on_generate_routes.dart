import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'package:safarni/features/hotel/presentation/views/hotel_item_view.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/hotel_about_view_body.dart';

import '../../features/auth/presentaion/pages/Password Reset Success.dart';
import '../../features/auth/presentaion/pages/Reset Password.dart';
import '../../features/auth/presentaion/pages/Verify Code.dart';
import '../../features/auth/presentaion/pages/forget_password.dart';
import '../../features/auth/presentaion/pages/get_start_page.dart';
import '../../features/auth/presentaion/pages/sign_in.dart';
import '../../features/auth/presentaion/pages/sign_up.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentaion/pages/splash_page.dart';


Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
      case GetStartedPage.routeName:
      return MaterialPageRoute(builder: (_) => const GetStartedPage());

      case VerifyCodePage.routeName:
      return MaterialPageRoute(builder: (_) => const VerifyCodePage());

      case SuccessPage.routeName:
      return MaterialPageRoute(builder: (_) => const SuccessPage());

      case ResetPasswordPage.routeName:
      return MaterialPageRoute(builder: (_) => const ResetPasswordPage());

      case ForgetPasswordPage.routeName:
      return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());

      case SignUpPage.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpPage());

      case SignInPage.routeName:
      return MaterialPageRoute(builder: (_) => const SignInPage());

    case HotelItemView.routeName:
      return MaterialPageRoute(builder: (_) => const HotelItemView());

    case AvailableRoomsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AvailableRoomsScreen());

    case WelcomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const WelcomeScreen());

    case OnboardingPage.routeName:
      return MaterialPageRoute(builder: (_) => const OnboardingPage());

    case HotelAboutPage.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (_) => HotelAboutPage(
          roomName: args?['roomName'] ?? 'Default Room Name',
          price: args?['price'] ?? '100',
          imageUrl: args?['imageUrl'] ?? Assets.assetsImagesHotel1,
          address: args?['address'] ?? '1012 Ocean Avenue, New York, USA',
          rating: args?['rating']?.toDouble() ?? 4.5,
          reviewsCount: args?['reviewsCount'] ?? 356,
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Unknown Route')),
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
