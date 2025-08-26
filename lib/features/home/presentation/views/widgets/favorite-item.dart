import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class FavoriteItem extends StatelessWidget {
   FavoriteItem({
    super.key,
    required this.image,
    required this.location,
    required this.price,
    required this.isFavorite,
    required this.onPressed,
  });

  final String image, location, price;
  bool isFavorite;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 0.1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Full Day Tour',
                                style: TextStyles.semiBold12.copyWith(
                                  color: AppColors.grayColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(location, style: TextStyles.medium16),
                        const SizedBox(height: 4.0),
                        Text.rich(
                          TextSpan(
                            style: TextStyles.bold14,
                            children: [
                              TextSpan(text: 'From '),
                              TextSpan(
                                text: '$price\$',
                                style: TextStyle(color: Color(0xff1c64f2)),
                              ),
                              TextSpan(text: ' Per Person'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: onPressed,
              icon: isFavorite
                  ? SvgPicture.asset('assets/icons/heart.svg')
                  : SvgPicture.asset('assets/icons/favorite.svg',),
            ),
          ),
        ],
      ),
    );
  }
}
