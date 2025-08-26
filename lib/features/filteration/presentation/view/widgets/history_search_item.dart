import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safarni/core/utils/app_styles.dart';

class HistoryFilterSearchItem extends StatelessWidget {
  const HistoryFilterSearchItem({
    super.key, required this.onClear, required this.title,
  });

  final VoidCallback onClear;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          border: Border.all(color: Color(0xffEBF5FF))
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: onClear, icon: SvgPicture.asset('assets/icons/cancel.svg')),
          Text(title,style: TextStyles.medium12,),
          SizedBox(width: 16,)
        ],
      ),
    );
  }
}
