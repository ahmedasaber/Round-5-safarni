import 'package:flutter/material.dart';
import 'package:safarni/core/utils/routes.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'package:safarni/features/hotel/presentation/views/hotel_item_view.dart';
import 'package:safarni/features/search/presentation/view/pages/result_view.dart';
import 'package:safarni/features/search/presentation/view/pages/search_view.dart';
import 'package:safarni/features/filteration/presentation/view/pages/filter_view.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/internal_tour/presentation/views/pages/destination_page.dart';
import 'package:safarni/features/internal_tour/presentation/views/pages/internal_tour_page.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/hotel_about_view_body.dart';
<<<<<<< HEAD

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homePage:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case Routes.internalTourPage:
      return MaterialPageRoute(builder: (_) => const InternalTourPage());
    case Routes.destinationPage:
      return MaterialPageRoute(builder: (_) => const DestinationPage());
=======


Route<dynamic> onGenerateRoute(RouteSettings settings){
  switch(settings.name){
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());

    case HotelItemView.routeName:
      return MaterialPageRoute(builder: (_) => const HotelItemView());

    case AvailableRoomsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AvailableRoomsScreen());

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

>>>>>>> 296de0e1da378c200631a2009c892649eaa5068c
    case SearchView.routeName:
      return MaterialPageRoute(builder: (_) => const SearchView());
     case ResultView.routeName:
      return MaterialPageRoute(builder: (_) => const ResultView());
    case FilterView.routeName:
      return MaterialPageRoute(builder: (_) => const FilterView());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Unknown Route')),
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}