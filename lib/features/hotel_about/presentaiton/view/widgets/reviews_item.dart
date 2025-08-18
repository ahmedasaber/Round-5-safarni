import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel_about/data/model/review_data.dart';
import 'dart:io';

import 'package:safarni/features/hotel_about/presentaiton/view/widgets/review_page.dart';

class ReviewItem extends StatelessWidget {
  final ReviewData? reviewData;

  const ReviewItem({super.key, this.reviewData});

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '${years} year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months} month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Default data if reviewData is null (for existing static reviews)
    final userName = reviewData?.userName ?? 'Dale Thiel';
    final rating = reviewData?.rating ?? 4;
    final reviewText =
        reviewData?.reviewText ??
        'I really enjoyed my stay—the room was clean and comfortable, and the staff was very friendly and helpful throughout my visit.';
    final timeAgo = reviewData != null
        ? _getTimeAgo(reviewData!.date)
        : '11 months ago';
    final images = reviewData?.images ?? <File>[];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue[100],
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName, style: TextStyles.font18DarkBlackNormal),
                  ],
                ),
              ),
              Text(timeAgo, style: TextStyles.font12DarkGrayNormal),
            ],
          ),

          verticalSpace(8),

          // Rating Stars
          Row(
            children: List.generate(5, (index) {
              if (index < rating) {
                return Icon(Icons.star, color: Colors.amber, size: 16);
              } else {
                return Icon(
                  Icons.star_border,
                  color: Colors.grey[400],
                  size: 16,
                );
              }
            }),
          ),

          verticalSpace(8),

          // Review Text
          Text(reviewText, style: TextStyles.font16DarkBlackNormal),

          // Review Images (if any)
          if (images.isNotEmpty) ...[
            verticalSpace(12),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      images[index],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
