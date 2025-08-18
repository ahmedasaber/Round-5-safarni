import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestVisitTime extends StatelessWidget {
  const BestVisitTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 24, bottom: 8),
          child: Text(
            "Best time to visit",
            style: TextStyles.font17BlackMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Container(
            width: double.infinity,
            height: 110.h,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Color(0xffD1D3DB), width: 2),
            ),
            child: Text(
              "Spring (April–June) and autumn (September–October) are perfect times to visit Paris, with mild weather and fewer tourists",
              style: TextStyles.font12DarkGreyRegular,
            ),
          ),
        ),
      ],
    );
  }
}
