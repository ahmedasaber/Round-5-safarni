import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingNavBar extends StatelessWidget {
  const BookingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.r),
          topRight: Radius.circular(18.r),
        ),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 50)],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Total price\n",
                    style: TextStyles.font16BlackRegular,
                  ),
                  TextSpan(
                    text: "\$150.00",
                    style: TextStyles.font17BlueSemiBold,
                  ),
                  TextSpan(
                    text: "/ per person",
                    style: TextStyles.font12DarkGreySemiBold,
                  ),
                ],
              ),
            ),
            CustomButton(
              onPressed: () {},
              color: AppColors.blue,
              text: "Book Now",
              textStyle: TextStyles.font16WhiteSemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
