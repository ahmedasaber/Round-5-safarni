import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';

class EmptySearchResultsWidget extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onShowAllHotels;

  const EmptySearchResultsWidget({
    super.key,
    required this.searchQuery,
    required this.onShowAllHotels,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey,
          ),
          verticalSpace(16),
          Text(
            'No hotels found for "$searchQuery"',
            style: TextStyles.font16LightBlackNormal,
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          ElevatedButton(
            onPressed: onShowAllHotels,
            child: const Text('Show All Hotels'),
          ),
        ],
      ),
    );
  }
}