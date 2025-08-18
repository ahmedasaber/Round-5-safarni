import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';

class CardRecommendationItem extends StatelessWidget {
  const CardRecommendationItem({
    super.key, required this.image, required this.title, required this.rate, required this.location,
  });
  final String image, title, rate, location;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .60,
      child: Card(
        color: Colors.white,
        shadowColor: Color(0x3F6F6F40),
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(image, fit: BoxFit.cover, height: 199, width: double.infinity,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(child: Text(title,style: TextStyles.medium14,overflow: TextOverflow.ellipsis,maxLines: 1,)),
                    SizedBox(width: 4,),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/Rate.svg'),
                        SizedBox(width: 4,),
                        Text(rate, style: TextStyles.semiBold12,)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/Location.svg'),
                    SizedBox(width: 8,),
                    Text(location, style: TextStyles.regular15.copyWith(color: AppColors.grayColor),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}