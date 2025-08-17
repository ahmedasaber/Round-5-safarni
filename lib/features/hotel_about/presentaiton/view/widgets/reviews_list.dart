import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_page.dart';
import 'package:safarni/features/hotel_about/presentaiton/view/widgets/reviews_item.dart';

class ReviewsList extends StatelessWidget {
  final List<ReviewData> reviews;

  const ReviewsList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review_outlined, size: 64, color: Colors.grey[400]),
            verticalSpace(16),
            Text(
              'No reviews yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(8),
            Text(
              'Be the first to share your experience!',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: reviews.length,
      separatorBuilder: (context, index) => verticalSpace(16),
      itemBuilder: (context, index) {
        return ReviewItem(reviewData: reviews[index]);
      },
    );
  }
}
