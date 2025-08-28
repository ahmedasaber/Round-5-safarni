import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class RoomsHeaderWidget extends StatelessWidget {
  final int? hotelId;
  final String currentSearchQuery;
  final bool isSearchActive;
  final VoidCallback onClearSearch;
  final VoidCallback onRefresh;

  const RoomsHeaderWidget({
    super.key,
    required this.hotelId,
    required this.currentSearchQuery,
    required this.isSearchActive,
    required this.onClearSearch,
    required this.onRefresh,
  });

  String _getRoomsTitle() {
    if (isSearchActive && currentSearchQuery.isNotEmpty) {
      return 'Search Results for "$currentSearchQuery"';
    } else if (hotelId != null) {
      return 'Available Rooms';
    } else {
      return 'All Available Rooms';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            _getRoomsTitle(),
            style: TextStyles.font17LightBlackNormal,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isSearchActive) ...[
          TextButton(
            onPressed: onClearSearch,
            child: Text('Clear Search', style: TextStyles.font15DarkBlueNormal),
          ),
        ] else ...[
          TextButton(
            onPressed: onRefresh,
            child: Text('Refresh', style: TextStyles.font15DarkBlueNormal),
          ),
        ],
      ],
    );
  }
}
