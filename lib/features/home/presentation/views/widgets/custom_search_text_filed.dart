import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class CustomSearchTextFiled extends StatelessWidget {
  const CustomSearchTextFiled({
    super.key, this.onTap, this.readOnly = false, this.onChange,
  });
  final VoidCallback? onTap;
  final ValueChanged? onChange;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffE5E7EB),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          onTap: onTap,
          onChanged: onChange,
          readOnly: readOnly,
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