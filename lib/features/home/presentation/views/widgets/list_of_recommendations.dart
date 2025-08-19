import 'package:flutter/material.dart';
import 'package:safarni/features/home/presentation/views/widgets/card_recommendation_item.dart';

class ListOfRecommendations extends StatelessWidget {
  const ListOfRecommendations({
    super.key,
    required this.list,
  });

  final List<CardRecommendationItem> list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: list.length,
        itemBuilder: (context, i){
          return list[i];
        }
      ),
    );
  }
}