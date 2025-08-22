  import 'package:flutter/material.dart';
  import 'package:safarni/core/utils/app_colors.dart';

  class HotelTabsSection extends StatelessWidget {
    final int selectedIndex;
    final Function(int) onTabChanged;

    const HotelTabsSection({
      super.key,
      required this.selectedIndex,
      required this.onTabChanged,
    });

    @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HotelTab(
            title: 'About',
            index: 0,
            isActive: selectedIndex == 0,
            onTap: onTabChanged,
          ),
          HotelTab(
            title: 'Gallery',
            index: 1,
            isActive: selectedIndex == 1,
            onTap: onTabChanged,
          ),
          HotelTab(
            title: 'Review',
            index: 2,
            isActive: selectedIndex == 2,
            onTap: onTabChanged,
          ),
        ],
      );
    }
  }

  class HotelTab extends StatelessWidget {
    final String title;
    final int index;
    final bool isActive;
    final Function(int) onTap;

    const HotelTab({
      super.key,
      required this.title,
      required this.index,
      required this.isActive,
      required this.onTap,
    });

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          margin: EdgeInsets.only(right: 24),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w400 : FontWeight.w400,
                  color: isActive ? AppColors.darkBlue : Colors.grey[600],
                ),
              ),
              if (isActive)
                Container(
                  margin: EdgeInsets.only(top: 4),
                  height: 2,
                  width: 40,
                  color: AppColors.darkBlue,
                ),
            ],
          ),
        ),
      );
    }
  }
