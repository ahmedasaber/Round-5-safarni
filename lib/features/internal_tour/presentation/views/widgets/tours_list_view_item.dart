import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/utils/routes.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToursListViewItem extends StatelessWidget {
  const ToursListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.destinationPage);
      },
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Row(
          children: [
            Container(
              height: 88.h,
              width: 88.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/paris.jpg"),
                ),
              ),
            ),
            SizedBox(width: 20.w),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Full Day tour", style: TextStyles.font12GreySemibold),
                    SizedBox(width: 100.w),
                    SvgPicture.asset(
                      "assets/svgs/star.svg",
                      width: 16.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 5.w),
                    Text("4.5", style: TextStyles.font12DarkGreySemiBold),
                  ],
                ),
                SizedBox(height: 4.h),
                Text("Eiffel tower", style: TextStyles.font16BlackMedium),
                SizedBox(height: 4.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: r"From ",
                        style: TextStyles.font14GreyBold,
                      ),
                      TextSpan(
                        text: "230\$",
                        style: TextStyles.font14GreyBold.copyWith(
                          color: Color(0xff1C64F2),
                        ),
                      ),
                      TextSpan(
                        text: " Per person",
                        style: TextStyles.font14GreyBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}