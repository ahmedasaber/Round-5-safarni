import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
          minimumSize: WidgetStateProperty.all(Size(double.infinity, 60.h)),
          side: WidgetStateProperty.all(
            BorderSide(color: AppColors.blue, width: 1.5),
          ),
        ),
        onPressed: () {},
        child: Text(text, style: TextStyles.font16BlueSemiBold),
      ),
    );
  }
}
