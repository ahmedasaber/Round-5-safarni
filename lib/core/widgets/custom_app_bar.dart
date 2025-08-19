import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({
    super.key, this.title, this.automaticallyImplyLeading = true, this.actionsList
  });
  final String? title;
  final bool automaticallyImplyLeading;
  final List<Widget>? actionsList;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title!=null? Text(title!) : null,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actionsList,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}