import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import '../../utils/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.buttonTitle,
    this.image,
    this.primaryButton = false,
    this.onPressed,
  });

  final String? image;
  final String buttonTitle;
  final bool primaryButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed, // حتى لو null مش هيبقى رمادي
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
              if (primaryButton) {
                return AppColors.primaryColor;
              } else {
                return Colors.transparent;
              }
            },
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            primaryButton ? Colors.white : AppColors.primaryColor,
          ),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TextStyles.borderRadiusMd),
              side: BorderSide(
                color: primaryButton? Colors.transparent : AppColors.primaryColor,
              ),
            ),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: primaryButton ? Colors.white : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
