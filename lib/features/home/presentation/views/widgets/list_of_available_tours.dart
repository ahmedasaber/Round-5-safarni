import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/features/destination/presentation/views/pages/detination_page.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/home/presentation/views/widgets/available_tours_card.dart';

class ListOfAvailableTours extends StatelessWidget {
  const ListOfAvailableTours({super.key, required this.toursList});

  final List<ToursEntity> toursList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: toursList.isNotEmpty ? 3 : 0,
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
    );
  }
}
