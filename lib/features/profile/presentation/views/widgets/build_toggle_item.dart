import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BuildToggleItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged; // made nullable to handle disabled state
  const BuildToggleItem({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyles.font14DarkBlackNormal.copyWith(
              color: onChanged == null ? Colors.grey : Colors.black,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: onChanged == null ? Colors.grey : Colors.blue,
            inactiveThumbColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}