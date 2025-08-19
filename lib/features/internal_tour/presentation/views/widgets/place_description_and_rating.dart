import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/rating.dart';

class PlaceDescriptionAndRating extends StatelessWidget {
  const PlaceDescriptionAndRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("City breaks", style: TextStyles.font12DarkGreySemiBold),
              Text("Eiffel tower", style: TextStyles.font16BlackSemiBold),
              SizedBox(height: 4.h),
              Text(
                "7 days and 6 nights",
                style: TextStyles.font14DarkGreyMedium,
              ),
              SizedBox(height: 2.h),
              Text("Paris,France", style: TextStyles.font12GreyMedium),
              SizedBox(height: 12.h),
             
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100, left: 70),
            child: Rating(),
          ),
        ],
      ),
    );
  }
}
