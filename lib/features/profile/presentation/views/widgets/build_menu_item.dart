import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BuildMenuItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final bool showArrow;
  const BuildMenuItem({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
    this.textColor,
    required this.showArrow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: ListTile(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Image.asset(image, height: 24, width: 24),
        title: Text(title, style: TextStyles.font14DarkBlackNormal),
        trailing: showArrow
            ? const Icon(Icons.chevron_right, color: Colors.black, size: 24)
            : null,
        onTap: onTap,
      ),
    );
  }
}
