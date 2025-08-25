import 'package:dartz/dartz.dart' as roomDetail;
import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/hotel_about_view_body.dart';
import 'package:safarni/features/hotel_about/presentation/view/widgets/safe_network_image.dart';

class BuildRoomCard extends StatelessWidget {
  final int roomId; // Add roomId parameter
  final String roomName;
  final String price;
  final String imageUrl;

  const BuildRoomCard({
    super.key,
    required this.roomId, // Make roomId required
    required this.roomName,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to HotelAboutPage with roomId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelAboutPage(
              roomId: roomId, // Pass the room ID to fetch details
              roomName: roomName,
              price: price.replaceAll('\$', ''),
              imageUrl: imageUrl,
              address: '1012 Ocean Avenue, New York, USA', // Default address
              rating: 0, // Will be updated from API
              reviewsCount: 0, // Will be updated from API
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: _buildImage(),
                ),
              ),
            ),
            // Room Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Room_${roomDetail.id}",
                      style: TextStyles.font13LightBlackNormal,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text('From ', style: TextStyles.font12DarkGrayNormal),
                        Text(price, style: TextStyles.font13LightBlueNormal),
                        Text(
                          ' Per Night',
                          style: TextStyles.font12DarkGrayNormal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl.startsWith('http')) {
      return SafeNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: 24,
      );
    } else {
      return Image.asset(
        imageUrl,
        height: double.infinity,
        width: 24,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 24,
            height: 24,
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              size: 16,
              color: Colors.grey[400],
            ),
          );
        },
      );
    }
  }
}
