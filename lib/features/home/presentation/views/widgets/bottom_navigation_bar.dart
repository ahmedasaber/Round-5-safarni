import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConvexNavBar extends StatelessWidget {
  const ConvexNavBar({
    super.key,
    required this.onTapSelected,
    required this.currentIndex,
  });

  final int currentIndex;
  final ValueChanged<int> onTapSelected;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      style: TabStyle.react,
      backgroundColor: Colors.white,
      activeColor: Color(0xff1E429F),
      color: Colors.grey[600],
      top: -16,
      items: [
        TabItem(
          icon: SvgPicture.asset('assets/icons/home.svg'),
          title: "Home",
          activeIcon: SvgPicture.asset('assets/icons/home-active.svg'),
        ),
        TabItem(
          icon: SvgPicture.asset('assets/icons/favorite.svg'),
          title: "Favorite",
          activeIcon: SvgPicture.asset('assets/icons/favorite-active.svg'),
        ),
        TabItem(
          icon: SvgPicture.asset('assets/icons/compare.svg'),
          title: "Compare",
          activeIcon: SvgPicture.asset('assets/icons/compare-active.svg'),
        ),
        TabItem(
          icon: SvgPicture.asset('assets/icons/map.svg'),
          title: "Maps",
          activeIcon: SvgPicture.asset('assets/icons/map-active.svg'),
        ),
      ],
      onTap: onTapSelected,
    );
  }
}
