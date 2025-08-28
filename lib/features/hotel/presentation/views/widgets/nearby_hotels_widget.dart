import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/presentation/views/screens/available_rooms_screen.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_nearby_hotel_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/section_header_widget.dart';

class NearbyHotelsWidget extends StatelessWidget {
  final List<HotelModel> nearbyHotels;

  const NearbyHotelsWidget({super.key, required this.nearbyHotels});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeaderWidget(
          title: 'Nearby Hotel',
          onViewAll: () {
            Navigator.pushNamed(context, AvailableRoomsScreen.routeName);
          },
        ),
        verticalSpace(16),
        if (nearbyHotels.isEmpty)
          const Center(child: Text('No nearby hotels available'))
        else
          Column(
            children: nearbyHotels.map((hotel) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: BuildNearbyHotelCard(
                  hotelId: hotel.id,
                  name: hotel.name,
                  location: hotel.location,
                  discount: '10%Off',
                  rating: hotel.averageRating,
                  imageUrl: hotel.image,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
