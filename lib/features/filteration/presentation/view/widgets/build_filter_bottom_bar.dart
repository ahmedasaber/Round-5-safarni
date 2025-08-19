import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BuildFilterBottomBar extends StatelessWidget {
  const BuildFilterBottomBar({
    super.key, required this.onClear, required this.onFound,
  });
  final VoidCallback onClear;
  final VoidCallback onFound;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onClear,
            child: Text(
              'Clear All',
              style: TextStyles.semiBold16.copyWith(color: Color(0xff1e429f)),
            ),
          ),
          ElevatedButton(
            onPressed: onFound,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Color(0xff1e429f),
              foregroundColor: Colors.white,
              textStyle: TextStyles.semiBold16.copyWith(
                fontFamily: 'Poppins',
              ),
            ),
            child: Text('56 Tours Found'),
          ),
        ],
      ),
    );
  }
}