import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';

class ReviewUserInfo extends StatelessWidget {
  final String userName;
  final String timeAgo;

  const ReviewUserInfo({
    super.key,
    required this.userName,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.blue[100],
          child: Text(
            userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(userName, style: TextStyles.font18DarkBlackNormal)],
          ),
        ),
        Text(timeAgo, style: TextStyles.font12DarkGrayNormal),
      ],
    );
  }
}
