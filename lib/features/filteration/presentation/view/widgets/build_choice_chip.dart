import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

ChoiceChip buildChoiceChip({
  required String label,
  required bool selected,
  required ValueChanged<bool> onSelected,
  Widget? icon,
}) {
  return ChoiceChip(
    label: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon ?? SizedBox(),
        icon != null? SizedBox(width: 4,) : SizedBox(),
        Text(
          label,
          style: TextStyles.medium12.copyWith(
            color: selected ? Color(0xff1e429f) : Colors.grey[500],
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xffEBF5FF)),
      borderRadius: BorderRadius.circular(38.0), // Customize the radius here
    ),
    showCheckmark: false,
    selectedColor: Color(0xffEBF5FF),
    selected: selected,
    onSelected: onSelected,
  );
}