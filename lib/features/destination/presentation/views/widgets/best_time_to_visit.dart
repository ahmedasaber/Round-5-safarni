import 'package:flutter/cupertino.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class BestTimeToVisit extends StatelessWidget {
  const BestTimeToVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TextStyles.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Best Time to Visit', style: TextStyle(fontSize: TextStyles.fontSizeMd, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(
            'Spring (April-June) and fall (September-October) are pleasant seasons with fewer crowds, ideal for exploring the city\'s attractions.',
            style: TextStyle(color: AppColors.softGrey),
          ),
        ],
      ),
    );
  }
}
