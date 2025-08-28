import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(title, style: TextStyles.font17LightBlackNormal),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: onBackPressed,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
