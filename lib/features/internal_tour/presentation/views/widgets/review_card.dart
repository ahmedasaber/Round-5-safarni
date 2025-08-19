import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class ReviewCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String time;
  final String review;

  const ReviewCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.time,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Color(0xffD1D5DB), // light grey border
          width: 0.5,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(avatar)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(name, style: TextStyles.font18BlackMedium),
                ),
                Text(
                  time,
                  style: TextStyles.font13DarkGreyMedium,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset("assets/svgs/star.svg"),
                SvgPicture.asset("assets/svgs/star.svg"),
                SvgPicture.asset("assets/svgs/star.svg"),
              ],
            ),
            const SizedBox(height: 8),
            Text(review, style: TextStyles.font16BlackRegular),
          ],
        ),
      ),
    );
  }
}