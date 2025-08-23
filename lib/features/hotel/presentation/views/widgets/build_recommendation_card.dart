import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/views/screens/avilable_rooms_screen.dart';

class BuildRecommendationCard extends StatelessWidget {
  final int hotelId; // ⭐ إضافة hotel ID
  final String name;
  final String location;
  final String discount;
  final double rating;
  final String imageUrl;

  const BuildRecommendationCard({
    super.key,
    required this.hotelId, // ⭐ إضافة hotel ID
    required this.name,
    required this.location,
    required this.discount,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('🎯 BuildNearbyHotelCard - Navigating with hotel ID: $hotelId');
        // ⭐ التنقل إلى شاشة الغرف المتاحة مع تمرير hotel ID
        Navigator.pushNamed(
          context,
          AvailableRoomsScreen.routeName,
          arguments: hotelId, // تمرير hotel ID
        );
      },
      child: Container(
        width: 217,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFE5E7EB), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 125,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 125,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey[400],
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFEBF5FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          discount,
                          style: TextStyles.font12DarkBlueNormal,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Assets.assetsImagesStar,
                            width: 18,
                            height: 18,
                          ),
                          horizontalSpace(6),
                          Text(
                            rating.toString(),
                            style: TextStyles.font12DarkGrayNormal,
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(12),
                  Text(name, style: TextStyles.font16LightBlackNormal),
                  verticalSpace(4),
                  Row(
                    children: [
                      Image.asset(
                        Assets.assetsImagesLocation,
                        width: 24,
                        height: 24,
                      ),
                      horizontalSpace(4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyles.font14DarkGrayNormal,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
