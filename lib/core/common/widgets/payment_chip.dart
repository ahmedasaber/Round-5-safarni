import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import '../../utils/app_colors.dart';

class PaymentChip extends StatelessWidget {
  const PaymentChip({
    super.key,
    required this.asset,
    required this.title,
    this.isSelected = false,
  });

  final String asset;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEBF5FF) : AppColors.darkerWhite,
          borderRadius: BorderRadius.circular(TextStyles.borderRadiusXlg),
        ),
        child: Row(
          children: [
            Image.asset(asset, width: 32),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryColor : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
