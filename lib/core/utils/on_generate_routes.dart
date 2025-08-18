import 'package:flutter/material.dart';
import 'package:safarni/core/utils/routes.dart';
import 'package:safarni/features/home/presentation/views/pages/home_view.dart';
import 'package:safarni/features/internal_tour/presentation/views/pages/destination_page.dart';
import 'package:safarni/features/internal_tour/presentation/views/pages/internal_tour_page.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.homePage:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case Routes.internalTourPage:
      return MaterialPageRoute(builder: (_) => const InternalTourPage());
    case Routes.destinationPage:
      return MaterialPageRoute(builder: (_) => const DestinationPage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text('Unknown Route')),
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
