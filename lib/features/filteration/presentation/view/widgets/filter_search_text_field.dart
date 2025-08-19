import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class FilterSearchTextFiled extends StatelessWidget {
  const FilterSearchTextFiled({
    super.key,
    this.onChange,
  });

  final ValueChanged? onChange;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.grayColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          onChanged: onChange,
          decoration: InputDecoration(
            hintText: 'Search ...',
            hintStyle: TextStyles.regular15.copyWith(color: AppColors.grayColor),
            icon: SvgPicture.asset('assets/icons/search-normal.svg'),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
