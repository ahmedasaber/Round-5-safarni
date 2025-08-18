import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BuildNearbyHotelCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String discount;
  final double rating;
  const BuildNearbyHotelCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.discount,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text(discount, style: TextStyles.font12DarkBlueNormal),
                ),
                verticalSpace(6),
                Text(name, style: TextStyles.font16LightBlackNormal),
                verticalSpace(4),
                Row(
                  children: [
                    Image.asset(Assets.assetsImagesLocation, width: 24),
                    horizontalSpace(4),
                    Text(
                      location,
                      style: TextStyles.font14DarkGrayNormal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Assets.assetsImagesStar, width: 16),
                horizontalSpace(4),
                Text(rating.toString(), style: TextStyles.font12DarkGrayNormal),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
