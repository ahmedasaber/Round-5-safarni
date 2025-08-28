import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/data/models/hotel_model.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_nearby_hotel_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_results_header_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/empty_search_results_widget.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<HotelModel> searchResults;
  final String? searchQuery;

  const SearchResultsWidget({
    super.key,
    required this.searchResults,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchResultsHeaderWidget(
          resultsCount: searchResults.length,
          onClearSearch: () => context.read<HotelCubit>().clearSearch(),
        ),
        if (searchQuery != null) ...[
          verticalSpace(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Showing results for: "$searchQuery"',
              style: TextStyles.font12DarkBlueNormal,
            ),
          ),
        ],
        verticalSpace(16),
        if (searchResults.isEmpty)
          EmptySearchResultsWidget(
            searchQuery: searchQuery ?? '',
            onShowAllHotels: () => context.read<HotelCubit>().clearSearch(),
          )
        else
          Column(
            children: searchResults.map((hotel) {
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
