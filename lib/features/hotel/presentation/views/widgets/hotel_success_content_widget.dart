import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_results_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/hotel_recommendations_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/nearby_hotels_widget.dart';

class HotelSuccessContentWidget extends StatelessWidget {
  final HotelSuccess state;

  const HotelSuccessContentWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBarWidget(),
          verticalSpace(18),
          if (state.isSearchMode && state.searchResults != null) ...[
            SearchResultsWidget(
              searchResults: state.searchResults!,
              searchQuery: state.searchQuery,
            ),
          ] else ...[
            HotelRecommendationsWidget(
              recommendedHotels: state.recommendedHotels,
            ),
            verticalSpace(16),
            NearbyHotelsWidget(nearbyHotels: state.nearbyHotels),
          ],
        ],
      ),
    );
  }
}
