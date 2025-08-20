import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/profile/presentation/views/screens/profile_view.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Disables the leading widget
      title: Transform.translate(
        offset: Offset(-16, 0),
        child: ListTile(
          title: Text('Welcome', style: TextStyles.medium16),
          subtitle: Text(
            'Explore The Best Places In World! ',
            style: TextStyles.regular13.copyWith(color: Color(0xff9CA3AF)),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          child: CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/profile-image.png'),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
