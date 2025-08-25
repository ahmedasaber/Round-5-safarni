import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

Text buildTitleWithSubtitle({required String text1, required String text2}) {
  return Text.rich(
      TextSpan(
          children: [
            TextSpan(text: text1, style: TextStyles.medium16),
            TextSpan(text: text2, style: TextStyles.regular14.copyWith(color: Colors.grey[500]))
          ]
      )
  );
}