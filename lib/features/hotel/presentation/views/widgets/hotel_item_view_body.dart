import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_nearby_hotel_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_recommendation_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class HotelItemViewBody extends StatelessWidget {
  const HotelItemViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(),
            verticalSpace(18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommendation',
                  style: TextStyles.font17LightBlackNormal,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AvailableRoomsScreen.routeName,
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyles.font15DarkBlueNormal,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 270,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  BuildRecommendationCard(
                    name: 'OasisOverture',
                    location: 'New York, USA',
                    discount: '10%Off',
                    rating: 4.8,
                    imageUrl: Assets.assetsImagesHotel1,
                  ),
                  horizontalSpace(16),
                  BuildRecommendationCard(
                    name: 'HiddenHaven',
                    location: 'New York, USA',
                    discount: '10%Off',
                    rating: 4.8,
                    imageUrl: Assets.assetsImagesHotel2,
                  ),
                ],
              ),
            ),
            verticalSpace(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nearby Hotel', style: TextStyles.font17LightBlackNormal),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AvailableRoomsScreen.routeName,
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyles.font15DarkBlueNormal,
                  ),
                ),
              ],
            ),
            verticalSpace(16),
            BuildNearbyHotelCard(
              name: 'GoldenValley',
              location: 'New York, USA',
              discount: '10%Off',
              rating: 4.5,
              imageUrl: Assets.assetsImagesNearbyHotel1,
            ),
            verticalSpace(16),
            BuildNearbyHotelCard(
              name: 'GoldenValley',
              location: 'New York, USA',
              discount: '10%Off',
              rating: 4.5,
              imageUrl: Assets.assetsImagesNearbyHotel2,
            ),
            verticalSpace(16),
            BuildNearbyHotelCard(
              name: 'GoldenValley',
              location: 'New York, USA',
              discount: '10%Off',
              rating: 4.5,
              imageUrl: Assets.assetsImagesNearbyHotel1,
            ),
          ],
        ),
      ),
    );
  }
}
