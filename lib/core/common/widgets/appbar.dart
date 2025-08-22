import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/app_styles.dart';

class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomizedAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.centerTitle = true,
  });

  final Widget? title;
  final bool centerTitle;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: TextStyles.defaultSpace,
        vertical: TextStyles.sm,
      ),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        leading:
        showBackArrow
            ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Iconsax.arrow_left_2,color:Colors.black ,),
        )
            : leadingIcon !=null? IconButton(
            onPressed: leadingOnPressed,
            icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight);
}
