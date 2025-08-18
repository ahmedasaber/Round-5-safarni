import 'package:flutter/material.dart';

class ReviewRating extends StatelessWidget {
  final int rating;

  const ReviewRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating) {
          return Icon(Icons.star, color: Colors.amber, size: 16);
        } else {
          return Icon(Icons.star_border, color: Colors.grey[400], size: 16);
        }
      }),
    );
  }
}
