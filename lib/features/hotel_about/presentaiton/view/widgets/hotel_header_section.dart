import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/discount_badge.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/rating_badge.dart';

class HotelHeaderSection extends StatelessWidget {
  final double rating;
  final int reviewsCount;
  final String roomName;
  final String address;

  const HotelHeaderSection({
    super.key,
    required this.rating,
    required this.reviewsCount,
    required this.roomName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DiscountBadge(),
            RatingBadge(rating: rating, reviewsCount: reviewsCount),
          ],
        ),
        verticalSpace(16),
        Text(roomName, style: TextStyles.font20LightBlackNormal),
        verticalSpace(8),
        // Address
        Text(address, style: TextStyles.font12DarkGrayNormal),
      ],
    );
  }
}
