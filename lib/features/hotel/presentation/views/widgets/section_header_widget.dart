import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.font17LightBlackNormal,
        ),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            'View all',
            style: TextStyles.font15DarkBlueNormal,
          ),
        ),
      ],
    );
  }
}