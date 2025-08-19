import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Gallery (200)', style: TextStyle(fontSize: TextStyles.fontSizeMd, fontWeight: FontWeight.bold)),
              Text('See more', style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w500,fontSize: TextStyles.fontSizeMd)),
            ],
          ),
          SizedBox(height: 15),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: TextStyles.gridViewSpacing,
            crossAxisSpacing: TextStyles.gridViewSpacing,
            children: [
              _buildGalleryImage('assets/images/gallery/gallery1.png'),
              _buildGalleryImage('assets/images/gallery/gallery2.png'),
              _buildGalleryImage('assets/images/gallery/gallery3.png'),
              _buildGalleryImage('assets/images/gallery/gallery4.png'),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo, color: AppColors.primaryColor),
                SizedBox(width: 5),
                Text('add Photo', style: TextStyle(color: AppColors.primaryColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildGalleryImage(String imagePath) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.asset(imagePath, fit: BoxFit.cover),
  );
}
