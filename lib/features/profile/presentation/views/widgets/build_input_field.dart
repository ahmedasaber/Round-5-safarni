import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BuildInputField extends StatelessWidget {
  final String label;
  final String icon;
  final String placeholder;
  const BuildInputField({
    super.key,
    required this.label,
    required this.icon,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.font14DarkBlackNormal),
        verticalSpace(6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: TextField(
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(icon, height: 18, width: 18),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              hintText: placeholder,
              hintStyle: TextStyles.font14DarkGrayNormal,
            ),
          ),
        ),
      ],
    );
  }
}
