import 'package:flutter/material.dart';

import '../widgets/best_time_to_visit.dart';
import '../widgets/botton_bar.dart';
import '../widgets/build_top_section.dart';
import '../widgets/gallery.dart';
import '../widgets/reviews.dart';
import '../widgets/top_activates.dart';
import '../widgets/trip_details.dart';

class DestinationView extends StatelessWidget {
  const DestinationView({super.key});
  static const routeName = '/destination';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // The image and app bar at the top
            BuildTopSection(),
            // The main trip details (City Breaks, title, etc.)
            TripDetails(),
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
      bottomNavigationBar: BottomBar(),
    );
  }
}
