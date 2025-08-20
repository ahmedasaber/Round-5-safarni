import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/screens/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_nearby_hotel_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_recommendation_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class HotelItemViewBody extends StatefulWidget {
  const HotelItemViewBody({super.key});

  @override
  State<HotelItemViewBody> createState() => _HotelItemViewBodyState();
}

class _HotelItemViewBodyState extends State<HotelItemViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<HotelCubit>().fetchAllHotelsData();
  }

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
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HotelError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: TextStyles.font16LightBlackNormal,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HotelCubit>().fetchAllHotelsData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is HotelSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarWidget(),
                  verticalSpace(18),
                  // Recommendation Section
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
                    child: state.recommendedHotels.isEmpty
                        ? const Center(
                            child: Text('No recommended hotels available'),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.recommendedHotels.length,
                            separatorBuilder: (context, index) =>
                                horizontalSpace(16),
                            itemBuilder: (context, index) {
                              final hotel = state.recommendedHotels[index];
                              return BuildRecommendationCard(
                                name: hotel.name,
                                location: hotel.location,
                                discount:
                                    '10%Off', // You might want to add this to your model
                                rating: hotel.averageRating,
                                imageUrl: hotel.image,
                              );
                            },
                          ),
                  ),
                  verticalSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nearby Hotel',
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
                  verticalSpace(16),
                  if (state.nearbyHotels.isEmpty)
                    const Center(child: Text('No nearby hotels available'))
                  else
                    Column(
                      children: state.nearbyHotels.map((hotel) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: BuildNearbyHotelCard(
                            name: hotel.name,
                            location: hotel.location,
                            discount:
                                '10%Off',
                            rating: hotel.averageRating,
                            imageUrl: hotel.image,
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
