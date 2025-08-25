import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';

import '../widgets/best_time_to_visit.dart';
import '../widgets/botton_bar.dart';
import '../widgets/build_top_section.dart';
import '../widgets/gallery.dart';
import '../widgets/reviews.dart';
import '../widgets/top_activates.dart';
import '../widgets/trip_details.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({super.key, required this.tourModel});
  static const routeName = '/destination';

  final TourModel tourModel;

  @override
  Widget build(BuildContext context) {
    log("destination page ${tourModel.toJson().toString()}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // The image and app bar at the top
            BuildTopSection(tour: tourModel),
            // The main trip details (City Breaks, title, etc.)
            TripDetails(
              rate: tourModel.rating.toString(),
              views: tourModel.views.toString(),
              location: tourModel.location,
              title: tourModel.title,
            ),
            // The "Top Activates" section
            TopActivates(),
            // The "Best Time to Visit" section
            BestTimeToVisit(),
            // The "Gallery" section
            Gallery(),
            // The "Reviews" section
            Reviews(),
            // Spacer to separate the content from the bottom button
            SizedBox(height: 100),
          ],
        ),
      ),
      // The fixed bottom bar with price and button
      bottomNavigationBar: BottomBar(price: tourModel.price.toString(),),
    );
  }
}
