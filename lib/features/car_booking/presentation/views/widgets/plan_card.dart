import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanCard extends StatelessWidget {
  final String price;
  final String title;
  final String subtitle;
  final bool isSelected;
  final String icon;

  const PlanCard({
    super.key,
    required this.price,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Color(0xff1C64F2) : AppColors.grayColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110.h,
            width: 35.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(icon),
                const SizedBox(height: 4),

                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? AppColors.blue : Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyles.font14BlackMedium),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
