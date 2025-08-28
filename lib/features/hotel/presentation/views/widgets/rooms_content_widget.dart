import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/room_search_bart_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/rooms_header_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/empty_rooms_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/rooms_grid_widget.dart';

class RoomsContentWidget extends StatelessWidget {
  final int? hotelId;
  final List<RoomModel> filteredRooms;
  final List<RoomModel> originalRooms;
  final String currentSearchQuery;
  final bool isSearchActive;
  final Function(String) onSearchChanged;
  final VoidCallback onClearSearch;
  final VoidCallback onRefresh;

  const RoomsContentWidget({
    super.key,
    required this.hotelId,
    required this.filteredRooms,
    required this.originalRooms,
    required this.currentSearchQuery,
    required this.isSearchActive,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocalRoomSearchWidget(
            hotelId: hotelId,
            onSearchChanged: onSearchChanged,
            onClearSearch: onClearSearch,
          ),
          verticalSpace(16),
          RoomsHeaderWidget(
            hotelId: hotelId,
            currentSearchQuery: currentSearchQuery,
            isSearchActive: isSearchActive,
            onClearSearch: onClearSearch,
            onRefresh: onRefresh,
          ),
          verticalSpace(16),
          if (filteredRooms.isEmpty) ...[
            EmptyRoomsWidget(
              hotelId: hotelId,
              originalRooms: originalRooms,
              currentSearchQuery: currentSearchQuery,
              isSearchActive: isSearchActive,
              onClearSearch: onClearSearch,
            ),
          ] else ...[
            RoomsGridWidget(
              filteredRooms: filteredRooms,
              currentSearchQuery: currentSearchQuery,
              isSearchActive: isSearchActive,
            ),
          ],
        ],
      ),
    );
  }
}
