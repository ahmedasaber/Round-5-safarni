import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BuildToggleItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const BuildToggleItem({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyles.font14DarkBlackNormal),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
            inactiveThumbColor: Colors.grey[300],
            inactiveTrackColor: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
