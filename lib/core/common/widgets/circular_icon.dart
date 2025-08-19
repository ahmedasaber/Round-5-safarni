import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({super.key,
    this.dark,
    this.width,
    this.height,
    this.size = TextStyles.lg,
    this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed
  });

  final bool? dark;
  final double? width, height, size;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  // DeliveryXColors.black.withOpacity(0.9) : DeliveryXColors.white.withOpacity(0.9),
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:
        backgroundColor != null
            ? backgroundColor!
            : dark
            ? AppColors.black.withOpacity(0.9)
            : AppColors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon,size: size,color: color,),),
    );
  }
}
