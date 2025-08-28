import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_room_card.dart';

class RoomsGridWidget extends StatelessWidget {
  final List<RoomModel> filteredRooms;
  final String currentSearchQuery;
  final bool isSearchActive;

  const RoomsGridWidget({
    super.key,
    required this.filteredRooms,
    required this.currentSearchQuery,
    required this.isSearchActive,
  });

  String _getResultsText() {
    if (isSearchActive) {
      return '${filteredRooms.length} rooms found for "$currentSearchQuery"';
    } else {
      return '${filteredRooms.length} rooms found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getResultsText(),
          style: TextStyles.font14DarkGrayNormal,
        ),
        verticalSpace(12),
        GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: filteredRooms.length,
          itemBuilder: (context, index) {
            final room = filteredRooms[index];
            return BuildRoomCard(
              roomId: room.id,
              roomName: room.name,
              price: '\$${room.price.toStringAsFixed(0)}',
              imageUrl: room.image,
            );
          },
        ),
      ],
    );
  }
}