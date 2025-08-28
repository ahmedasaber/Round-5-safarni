import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';

class EmptyRoomsWidget extends StatelessWidget {
  final int? hotelId;
  final List<RoomModel> originalRooms;
  final String currentSearchQuery;
  final bool isSearchActive;
  final VoidCallback onClearSearch;

  const EmptyRoomsWidget({
    super.key,
    required this.hotelId,
    required this.originalRooms,
    required this.currentSearchQuery,
    required this.isSearchActive,
    required this.onClearSearch,
  });

  String _getEmptyRoomsMessage() {
    if (isSearchActive && currentSearchQuery.isNotEmpty) {
      return 'No rooms found for "$currentSearchQuery"';
    } else if (hotelId != null) {
      return 'No rooms available in this hotel today';
    } else {
      return 'No rooms available for today';
    }
  }

  String _getEmptyRoomsSubtitle() {
    if (isSearchActive) {
      return 'Try searching with different keywords or clear the search to see all available rooms.';
    } else if (hotelId != null) {
      return 'This hotel has no available rooms for today.';
    } else {
      return 'No rooms are currently available.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              isSearchActive ? Icons.search_off : Icons.hotel_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            verticalSpace(16),
            Text(
              _getEmptyRoomsMessage(),
              style: TextStyles.font16LightBlackNormal,
              textAlign: TextAlign.center,
            ),
            verticalSpace(8),
            Text(
              _getEmptyRoomsSubtitle(),
              style: TextStyles.font14DarkGrayNormal,
              textAlign: TextAlign.center,
            ),
            if (isSearchActive) ...[
              verticalSpace(16),
              ElevatedButton(
                onPressed: onClearSearch,
                child: const Text('Show All Rooms'),
              ),
            ] else if (hotelId != null && originalRooms.isEmpty) ...[
              verticalSpace(16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Try Another Hotel'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
