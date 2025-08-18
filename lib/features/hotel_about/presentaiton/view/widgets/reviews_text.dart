import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class ReviewText extends StatelessWidget {
  final String reviewText;
  
  const ReviewText({
    super.key, 
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      reviewText,
      style: TextStyles.font16DarkBlackNormal,
    );
  }
}