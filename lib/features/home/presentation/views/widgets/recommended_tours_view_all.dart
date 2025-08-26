import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';
import 'package:safarni/features/home/presentation/views/widgets/card_recommendation_item.dart';

import '../../../../destination/presentation/views/pages/detination_page.dart';

class RecommendedToursViewAll extends StatelessWidget {
  const RecommendedToursViewAll({super.key, required this.tours});

  static const routeName = 'recommend view all';
  final List<TourModel> tours;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Recommendation',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          clipBehavior: Clip.none,
          itemCount: tours.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              child: CardRecommendationItem(
                image: tours[i].image,
                title: tours[i].title,
                rate: tours[i].rating.toStringAsFixed(1),
                location: tours[i].location,
              ),
              onTap: (){
                context.pushNamed(DestinationView.routeName, arguments: DestinationView(tourModel: TourModel.fromEntity(tours[i])));
              },
            );
          },
        ),
      ),
    );
  }
}
