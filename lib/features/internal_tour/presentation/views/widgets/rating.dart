import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100.w),
        SvgPicture.asset("assets/svgs/star.svg"),
        SvgPicture.asset("assets/svgs/star.svg"),
        SvgPicture.asset("assets/svgs/star.svg"),
        SizedBox(width: 5),
        Text("4.5", style: TextStyles.font12DarkGreySemiBold),
        Text("(675)", style: TextStyles.font10GreySemiBold),
      ],
    );
  }
}
