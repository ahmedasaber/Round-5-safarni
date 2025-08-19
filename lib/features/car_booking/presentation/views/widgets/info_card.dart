import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';


class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  const InfoCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffF3F4F6), width: 3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyles.font14BlackMedium),
            const SizedBox(height: 4),
            Text(value, style: TextStyles.font12DarkGreyRegular),
          ],
        ),
      ),
    );
  }
}