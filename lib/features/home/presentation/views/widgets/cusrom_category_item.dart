import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class CustomCategoryItem extends StatelessWidget {
  const CustomCategoryItem({
    super.key, required this.categoryImage, required this.categoryTitle,
  });
  final String categoryImage, categoryTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            categoryImage,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/placeholder.png',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(height: 8,),
        Text(categoryTitle, style: TextStyles.medium13.copyWith(color: Color(0xff1A56DB)),)
      ],
    );
  }
}