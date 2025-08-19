import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopActivateCard extends StatelessWidget {
  const TopActivateCard({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r), // More rounded
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r), // Match container
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 6.h),
            Text(text, style: TextStyles.font15BlackRegular),
          ],
        ),
      ),
    );
  }
}
