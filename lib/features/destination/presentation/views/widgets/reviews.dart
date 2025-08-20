import 'package:flutter/material.dart';
import 'package:safarni/core/common/widgets/elevated_button.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          _buildReviewCard(
            'Dale Thiel',
            '11 months ago',
            'Such a dreamy place! The views were stunning and the atmosphere was so romantic. It felt like a fairytale moment in the heart of Paris.',
            AppAssets.user1
          ),
          SizedBox(height: 15),
          _buildReviewCard(
            'Léo Martin',
            '6 months ago',
            'A beautiful escape from the ordinary. Everything was elegant and peaceful - the perfect setting for a special night in Paris.',
              AppAssets.user2
          ),
          SizedBox(height: 15),
          Center(
            child: AppElevatedButton(buttonTitle: "See More"),
          ),
        ],
      ),
    );
  }
}

Widget _buildReviewCard(String name, String time, String reviewText,String image) {
  return Container(
    padding: EdgeInsets.all(TextStyles.defaultSpace - 9),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(TextStyles.borderRadiusLg - 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              // Add a user image here
              backgroundColor: Colors.grey.shade200,
              // Add a user image here
              child: Image.asset(image),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Row(
                    children: List.generate(5, (index) => Icon(Icons.star, color: Colors.amber, size: TextStyles.iconSm)),
                  ),
                ],
              ),
            ),
            Text(time, style: TextStyle(color: AppColors.softGrey)),
          ],
        ),
        SizedBox(height: 10),
        Text(reviewText, style: TextStyle(color: Colors.black54)),
      ],
    ),
  );
}