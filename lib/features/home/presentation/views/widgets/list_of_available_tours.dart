import 'package:flutter/material.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/home/presentation/views/widgets/available_tours_card.dart';

class ListOfAvailableTours extends StatelessWidget {
  const ListOfAvailableTours({
    super.key,
    required this.toursList,
  });

  final List<ToursEntity> toursList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: toursList.isNotEmpty ? 3 : 0,
      itemBuilder: (context, i) {
        return AvailableToursCardItem(
          image: toursList[i].image,
          location: toursList[i].location,
          price: toursList[i].price.toString(),
          rate: toursList[i].rating.toStringAsFixed(1),
        );
      });
  }
}