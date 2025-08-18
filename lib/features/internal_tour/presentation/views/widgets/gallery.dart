import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "Gallery",
                  style: TextStyles.font17BlackMedium,
                  children: [
                    TextSpan(
                      text: " (150)",
                      style: TextStyles.font17BlueMedium,
                    ),
                  ],
                ),
              ),
              Text("See more", style: TextStyles.font15BlueMedium),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(4.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: AssetImage("assets/images/paris.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
