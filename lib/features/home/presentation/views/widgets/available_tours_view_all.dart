import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extensions.dart';
import 'package:safarni/features/destination/presentation/views/pages/destination_page.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';
import 'package:safarni/features/home/presentation/views/widgets/available_tours_card.dart';

import '../../../../../core/widgets/custom_app_bar.dart' show CustomAppBar;

class AvailableToursViewAll extends StatelessWidget {
  const AvailableToursViewAll({super.key, required this.toursList});
  static const routeName = 'available view all';
  final List<TourModel> toursList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Available Tours',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemCount: toursList.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                context.pushNamed(
                  DestinationView.routeName,
                  arguments: DestinationView(tourModel: TourModel.fromEntity(toursList[i])),
                );
              },
              child: AvailableToursCardItem(
                image: toursList[i].image,
                location: toursList[i].location,
                price: toursList[i].price.toString(),
                rate: toursList[i].rating.toStringAsFixed(1),
              ),
            );
          },
        ),
      ),
    );
  }
}
