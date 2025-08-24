import 'package:flutter/material.dart';
import 'package:safarni/core/utils/routes.dart';
import 'package:safarni/core/utils/app_assets.dart';
import '../../features/auth/presentaion/pages/sign_in.dart';
import '../../features/auth/presentaion/pages/sign_up.dart';
import '../../features/auth/presentaion/pages/Verify Code.dart';
import '../../features/splash/presentaion/pages/splash_page.dart';
import '../../features/auth/presentaion/pages/Reset Password.dart';
import '../../features/auth/presentaion/pages/get_start_page.dart';
import '../../features/auth/presentaion/pages/forget_password.dart';
import '../../features/auth/presentaion/pages/Password Reset Success.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/services.dart'; // Add this import for SystemNavigator
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'package:safarni/features/hotel/presentation/views/hotel_item_view.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';
import 'package:safarni/features/search/presentation/view/pages/search_view.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';
import 'package:safarni/features/search/presentation/view/pages/search_view.dart';
import 'package:safarni/features/filteration/presentation/view/pages/filter_view.dart';
import 'package:safarni/features/filteration/presentation/view/pages/filter_view.dart';
import 'package:safarni/features/profile/presentation/views/screens/profile_view.dart';
import 'package:safarni/features/profile/presentation/views/screens/profile_view.dart';
import 'package:safarni/features/profile/presentation/views/screens/profile_view.dart';
import 'package:safarni/features/car_booking/presentation/views/pages/car_details.dart';
import 'package:safarni/features/booking_flight/presentation/view/choose_seat_view.dart';
import 'package:safarni/features/booking_flight/presentation/view/boarding_pass_view.dart';
import 'package:safarni/features/booking_flight/presentation/view/select_flight_view.dart';
import 'package:safarni/features/booking_flight/presentation/view/flight_booking_view.dart';
import 'package:safarni/features/destination/presentation/views/pages/detination_page.dart';
import 'package:safarni/features/payment/presentation/views/pages/payment_method_view.dart';
import 'package:safarni/features/profile/presentation/views/screens/my_booking_screen.dart';
import 'package:safarni/features/payment/presentation/views/pages/success_payment_view.dart';
import 'package:safarni/features/car_booking/presentation/views/pages/car_booking_page.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/internal_tour/presentation/views/pages/destination_page.dart';
import 'package:safarni/features/internal_tour/presentation/views/pages/internal_tour_page.dart';
import 'package:safarni/features/profile/presentation/views/screens/account_security_screen.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/hotel_about_view_body.dart';
import 'package:safarni/features/profile/presentation/views/screens/personal_information_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.internalTourPage:
      return MaterialPageRoute(builder: (_) => const InternalTourPage());
    case Routes.destinationPage:
      return MaterialPageRoute(builder: (_) => const DestinationPage());
    case Routes.carBookingPage:
      return MaterialPageRoute(builder: (_) => const CarBookingPage());
    case Routes.carDetailsPage:
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (_) => CarDetailsPage(carId: id));
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
    case ProfileScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ProfileScreen());
    case PersonalInformationScreen.routeName:
      return MaterialPageRoute(builder: (_) => PersonalInformationScreen());

    case SearchView.routeName:
      return MaterialPageRoute(builder: (_) => const SearchView());
    case ResultView.routeName:
      return MaterialPageRoute(builder: (_) => const ResultView());
    case FilterView.routeName:
      return MaterialPageRoute(builder: (_) => const FilterView());
    case AccountSecurityScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AccountSecurityScreen());
    case MyBookingScreen.routeName:
      return MaterialPageRoute(builder: (_) => const MyBookingScreen());
    case DestinationView.routeName:
      return MaterialPageRoute(builder: (_) => const DestinationView());
    case PaymentMethodView.routeName:
      return MaterialPageRoute(builder: (_) => const PaymentMethodView());
    case SuccessPaymentView.routeName:
      return MaterialPageRoute(builder: (_) => const SuccessPaymentView());
    case FlightBookingView.routeName:
      return MaterialPageRoute(builder: (_) => const FlightBookingView());
    case SelectFlightView.routeName:
      return MaterialPageRoute(builder: (_) => const SelectFlightView());
    case ChooseSeatView.routeName:
      return MaterialPageRoute(builder: (_) => const ChooseSeatView());
    case BoardingPassView.routeName:
      return MaterialPageRoute(builder: (_) => const BoardingPassView());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text('Page Not Found')),
          body: Center(child: Text('Route not found: ${settings.name}')),
        ),
      );
  }
}
