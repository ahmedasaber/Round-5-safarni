import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safarni/core/utils/app_styles.dart';

class AdventureStyleFilterGroup extends StatefulWidget {
   const AdventureStyleFilterGroup({super.key, required this.selectedStyles});

   final List selectedStyles;
  @override
  State<AdventureStyleFilterGroup> createState() => _AdventureStyleFilterGroupState();
}

class _AdventureStyleFilterGroupState extends State<AdventureStyleFilterGroup> {
  List adventureStyles = [
    {'icon':'assets/icons/adventure-travel.svg', 'label':'Adventure Travel',},
    { 'icon':'assets/icons/buildings.svg', 'label':'City Breaks',},
    {'icon':'assets/icons/water-activity.svg', 'label':'Water Activity',},
    { 'icon':'assets/icons/road-trips.svg', 'label':'Road Trips',
    }];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: adventureStyles.map((style){
        bool isSelected = widget.selectedStyles.contains(style['label']);
        return FilterChip(
            label: Text(style['label'], style: TextStyles.medium12.copyWith(
              color: isSelected ? Color(0xff1e429f) : Colors.grey[500],
            ),),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color(0xffEBF5FF)),
              borderRadius: BorderRadius.circular(38.0), // Customize the radius here
            ),
            backgroundColor: Colors.white,
            selected: isSelected,
            selectedColor: Color(0xffEBF5FF),
            showCheckmark: false,
            avatar: SvgPicture.asset(
              style['icon'],
              color: isSelected ? const Color(0xff1e429f) : Colors.grey[500],
            ),
            avatarBorder: const CircleBorder(side: BorderSide(color: Colors.transparent)),
            onSelected: (value){
              value? widget.selectedStyles.add(style['label']) : widget.selectedStyles.remove(style['label']);
              setState(() {});
            }
        );
      }).toList(),
    );
  }
}
