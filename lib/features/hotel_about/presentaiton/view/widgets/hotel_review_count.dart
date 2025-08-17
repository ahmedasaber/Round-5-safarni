import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_header.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_page.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_searsh_bar.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/reviews_list.dart';

class HotelReviewContent extends StatelessWidget {
  final List<ReviewData> reviews;
  final Function(ReviewData) onReviewAdded;
  final String hotelName;
  final String address;
  final double rating;
  final int reviewsCount;

  const HotelReviewContent({
    super.key,
    required this.reviews,
    required this.onReviewAdded,
    required this.hotelName,
    required this.address,
    required this.rating,
    required this.reviewsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewHeader(
          onReviewAdded: onReviewAdded,
          hotelName: hotelName,
          address: address,
          rating: rating,
          reviewsCount: reviewsCount,
        ),
        verticalSpace(16),
        ReviewSearchBar(),
        verticalSpace(16),
        Expanded(child: ReviewsList(reviews: reviews)),
      ],
    );
  }
}
