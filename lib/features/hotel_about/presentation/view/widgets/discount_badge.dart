import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xffEBF5FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('10%Off', style: TextStyles.font12DarkBlueNormal),
    );
  }
}
