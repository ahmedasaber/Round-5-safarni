import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'package:safarni/features/hotel/presentation/views/hotel_item_view.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/hotel_about_view_body.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
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

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Unknown Route')),
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
