import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.text,
    required this.textStyle,
    this.width,
  });

  final Color color;
  final String text;
  final TextStyle textStyle;
  final double? width; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}
