import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safarni/core/common/widgets/circular_icon.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';

class BuildTopSection extends StatefulWidget {
  const BuildTopSection({super.key, required this.tour, required this.favoriteLocalDataSource});

  final TourModel tour;
  final FavoriteLocalDataSource favoriteLocalDataSource;
  @override
  State<BuildTopSection> createState() => _BuildTopSectionState();
}

class _BuildTopSectionState extends State<BuildTopSection> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.destinationImageSlider1, // Replace with your image path
          fit: BoxFit.cover,
          height: 350,
          width: double.infinity,
        ),

        //back button
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: CircularIcon(
              icon: Icons.arrow_back_ios,
              color: Colors.black
            ),
            onPressed: () {
              context.pop();
            },
          ),
        ),

        // favorite button
        Positioned(
          top: 40,
          right: 10,
          child: CircularIcon(
            onPressed: (){
              widget.tour.isFav = !widget.tour.isFav;
              widget.favoriteLocalDataSource.toggleFavorite(widget.tour);
              setState((){});
            },
            icon: Iconsax.heart5,
            color:  widget.tour.isFav? Colors.red : Colors.grey
          )
        ),
        Positioned(
          bottom: 20,
          right: 160,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(Icons.image, color: Colors.black, size: 16),
                SizedBox(width: 5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '4',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: '/9',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
