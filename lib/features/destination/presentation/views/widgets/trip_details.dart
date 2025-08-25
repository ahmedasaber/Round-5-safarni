import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({super.key, required this.rate, required this.views, required this.location, required this.title});
  final String title;
  final String rate;
  final String views;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TextStyles.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('City Breaks', style: TextStyle(color: AppColors.softGrey,fontWeight: FontWeight.w600)),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < 4 ? Icons.star : Icons.star_half,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
              Text('$rate ($views)', style: TextStyle(color: AppColors.grey)),
            ],
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: TextStyles.fontSizeLg + 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text('6 Days and 4 Nights', style: TextStyle(color: AppColors.softGrey,fontWeight: FontWeight.w600)),
          SizedBox(height: 5),
          Text(location, style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
