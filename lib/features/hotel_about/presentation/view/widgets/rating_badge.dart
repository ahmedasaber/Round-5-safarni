import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final int reviewsCount;

  const RatingBadge({
    super.key,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Image.asset(Assets.assetsImagesStar, height: 16, width: 16),
          horizontalSpace(4),
          Text(
            '$rating($reviewsCount Reviews)',
            style: TextStyles.font12DarkGrayNormal,
          ),
        ],
      ),
    );
  }
}
