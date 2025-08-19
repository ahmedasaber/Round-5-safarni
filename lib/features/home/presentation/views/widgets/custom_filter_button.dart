import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomFilterBt extends StatelessWidget {
  const CustomFilterBt({
    super.key, required this.onTap,
  });

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xffE5E7EB),
            )
        ),
        child: SvgPicture.asset('assets/icons/filter.svg', height: 20,width:20 ,),
      ),
    );
  }
}