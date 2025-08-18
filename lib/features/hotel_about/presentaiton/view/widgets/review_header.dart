import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_page.dart';

class ReviewHeader extends StatelessWidget {
  final Function(ReviewData)? onReviewAdded;
  final String? hotelName;
  final String? address;
  final double? rating;
  final int? reviewsCount;
  
  const ReviewHeader({
    super.key,
    this.onReviewAdded,
    this.hotelName,
    this.address,
    this.rating,
    this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Reviews', style: TextStyles.font17LightBlackNormal),
        GestureDetector(
          onTap: () {
            showAddReviewModal(
              context,
              hotelName: hotelName ?? 'HarborHaven Hideaway',
              address: address ?? '1012 Ocean Avenue, New York, USA',
              rating: rating ?? 4.5,
              reviewsCount: reviewsCount ?? 356,
              onReviewAdded: onReviewAdded ?? (review) {},
            );
          },
          child: Row(
            children: [
              Image.asset(Assets.assetsImagesIconReview, height: 20, width: 20),
              horizontalSpace(4),
              Text('add Review', style: TextStyles.font15DarkBlueNormal),
            ],
          ),
        ),
      ],
    );
  }
}