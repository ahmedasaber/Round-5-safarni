import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/rating.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/destination_image.dart';

class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DestinationImage(),

          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 18),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "City breaks",
                      style: TextStyles.font12DarkGreySemiBold,
                    ),
                    Text("Eiffel tower", style: TextStyles.font16BlackSemiBold),
                    SizedBox(height: 4.h),
                    Text(
                      "7 days and 6 nights",
                      style: TextStyles.font14DarkGreyMedium,
                    ),
                    SizedBox(height: 2.h),
                    Text("Paris,France", style: TextStyles.font12GreyMedium),
                    SizedBox(height: 12.h),
                    Text("Top Activates", style: TextStyles.font17BlackMedium),
                    SizedBox(height: 8.h),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100, left: 50),
                  child: Rating(),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r), // More rounded
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        16.r,
                      ), // Match container
                      child: Image.asset(
                        "assets/images/activate1.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text("Go to the Top"),
                ],
              ),
              SizedBox(width: 16.w),
              Column(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(
                        "assets/images/activate2.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text("Louvre at Night", style: TextStyles.font15BlackRegular),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
