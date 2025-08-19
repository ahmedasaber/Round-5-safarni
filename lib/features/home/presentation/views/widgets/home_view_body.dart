import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/features/search/presentation/view/pages/search_view.dart';
import 'package:safarni/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:safarni/features/filteration/presentation/view/pages/filter_view.dart';
import 'package:safarni/features/home/presentation/views/widgets/available_tours_card.dart';
import 'package:safarni/features/home/presentation/views/widgets/cusrom_category_item.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_filter_button.dart';
import 'package:safarni/features/home/presentation/views/widgets/list_of_recommendations.dart';
import 'package:safarni/features/home/presentation/views/widgets/card_recommendation_item.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_search_text_field.dart';

class HomeViewBody extends StatelessWidget {
  HomeViewBody({super.key});

  List<CardRecommendationItem> recomList = [
    CardRecommendationItem(
      image: 'assets/images/pyramids.jpg',
      title: 'The Pyramids',
      rate: '4.8',
      location: 'Giza',
    ),
    CardRecommendationItem(
      image: 'assets/images/Citadels-of-qaitbay.jpg',
      title: 'The Citadel of Saladin',
      rate: '4.8',
      location: 'Cairo',
    ),
    CardRecommendationItem(
      image: 'assets/images/karnk.jpg',
      title: 'Karnak Temple',
      rate: '4.8',
      location: 'Luxor',
    ),
    CardRecommendationItem(
      image: 'assets/images/libarary.jpg',
      title: 'Library of Alexandria',
      rate: '4.8',
      location: 'Alexandria',
    ),
  ];

  List<AvailableToursCardItem> toursList = [
    AvailableToursCardItem(
      image: 'assets/images/fayoum.jpg',
      location: 'Fayoum',
      price: '200',
      rate: '4.2',
    ),
    AvailableToursCardItem(
      image: 'assets/images/dahab.jpg',
      location: 'Dahab',
      price: '250',
      rate: '4.5',
    ),
    AvailableToursCardItem(
      image: 'assets/images/luxor.jpg',
      location: 'Luxor',
      price: '150',
      rate: '4.3',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                      child: CustomSearchTextField(
                    onTap: () {
                      context.pushNamed(SearchView.routeName);
                    },
                    readOnly: true,
                  )),
                  SizedBox(width: 16),
                  CustomFilterBt(
                    onTap: () {
                      context.pushNamed(FilterView.routeName);
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 221,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
                child: Image.asset(
                  'assets/images/travel-image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categories',
                style: TextStyles.medium17,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomCategoryItem(
                    categoryImage: 'assets/images/flight-category.jpg',
                    categoryTitle: 'Flight',
                  ),
                  CustomCategoryItem(
                    categoryImage: 'assets/images/car-category.jpg',
                    categoryTitle: 'Cars',
                  ),
                  CustomCategoryItem(
                    categoryImage: 'assets/images/tours-category.jpg',
                    categoryTitle: 'Tours',
                  ),
                  CustomCategoryItem(
                    categoryImage: 'assets/images/hotel-category.jpg',
                    categoryTitle: 'Hotels',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommendation', style: TextStyles.medium17),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyles.medium13.copyWith(
                        color: Color(0xff1E429F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: ListOfRecommendations(list: recomList),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Tours', style: TextStyles.medium17),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyles.medium13.copyWith(
                        color: Color(0xff1E429F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: toursList.length,
                itemBuilder: (context, i) {
                  return toursList[i];
                }),
          ],
        ),
      ),
    );
  }
}
