import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/presentation/views/screens/available_rooms_screen.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_recommendation_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/section_header_widget.dart';

class HotelRecommendationsWidget extends StatelessWidget {
  final List<HotelModel> recommendedHotels;

  const HotelRecommendationsWidget({
    super.key,
    required this.recommendedHotels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeaderWidget(
          title: 'Recommendation',
          onViewAll: () {
            Navigator.pushNamed(context, AvailableRoomsScreen.routeName);
          },
        ),
        SizedBox(
          height: 270,
          child: recommendedHotels.isEmpty
              ? const Center(child: Text('No recommended hotels available'))
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedHotels.length,
                  separatorBuilder: (context, index) => horizontalSpace(16),
                  itemBuilder: (context, index) {
                    final hotel = recommendedHotels[index];
                    return BuildRecommendationCard(
                      hotelId: hotel.id,
                      name: hotel.name,
                      location: hotel.location,
                      discount: '10%Off',
                      rating: hotel.averageRating,
                      imageUrl: hotel.image,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
