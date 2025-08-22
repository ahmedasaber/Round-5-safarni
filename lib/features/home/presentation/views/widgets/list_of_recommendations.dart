import 'package:flutter/material.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/home/presentation/views/widgets/card_recommendation_item.dart';

class ListOfRecommendations extends StatelessWidget {
  const ListOfRecommendations({super.key, required this.recommendedList});

  final List<ToursEntity> recommendedList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: recommendedList.length,
        itemBuilder: (context, i) {
          return CardRecommendationItem(
            image: recommendedList[i].image,
            title: recommendedList[i].title,
            rate: recommendedList[i].rating.toStringAsFixed(1),
            location: recommendedList[i].location,
          );
        },
      ),
    );
  }
}
