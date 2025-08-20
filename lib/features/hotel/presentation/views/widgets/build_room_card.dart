import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/presentation/view/screens/hotel_about_view_body.dart';

class BuildRoomCard extends StatelessWidget {
  final String roomName;
  final String price;
  final String imageUrl;
  const BuildRoomCard({
    super.key,
    required this.roomName,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          HotelAboutPage.routeName,
          arguments: {
            'roomName': roomName,
            'price': price.replaceAll('\$', ''),
            'imageUrl': imageUrl,
          },
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
                      roomName,
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
    // Check if imageUrl is a network URL or asset path
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return Image.network(
        imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.error, color: Colors.grey, size: 40),
          );
        },
      );
    } else {
      // Use Image.asset for local assets
      return Image.asset(
        imageUrl,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[300],
            child: const Icon(Icons.error, color: Colors.grey, size: 40),
          );
        },
      );
    }
  }
}
