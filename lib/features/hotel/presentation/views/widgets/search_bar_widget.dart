import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search ...',
          hintStyle: TextStyles.font15LightGrayNormal,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 30),
        ),
      ),
    );
  }
}
