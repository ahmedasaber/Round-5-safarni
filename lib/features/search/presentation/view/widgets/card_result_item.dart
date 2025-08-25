import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/destination/presentation/views/pages/detination_page.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';

class CardResultItem extends StatefulWidget {
  const CardResultItem({
    super.key,
    required this.tourModel,

  });

  final TourModel tourModel;
  @override
  State<CardResultItem> createState() => _CardResultItemState();
}

class _CardResultItemState extends State<CardResultItem> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(DestinationView.routeName,arguments: DestinationView(tourModel: widget.tourModel));
      },
      child: Card(
        color: Colors.white,
        shadowColor: Colors.grey.withValues(alpha: 0.1),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image.network(
                        widget.tourModel.image,
                        fit: BoxFit.cover,
                        height: 199,
                        width: double.infinity,
                        errorBuilder: (_,_,_){
                          return Image.asset(
                              'assets/images/placeholder.png',
                              fit: BoxFit.cover,
                              height: 199,
                              width: double.infinity,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.tourModel.title,
                            style: TextStyles.semiBold17,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(width: 4),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/Rate.svg'),
                            SizedBox(width: 4),
                            Text(widget.tourModel.rating.toString(), style: TextStyles.semiBold12),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text('Pickup Available', style: TextStyles.regular14.copyWith(color: AppColors.grayColor)),
                        SizedBox(width: 8,),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Container(padding:EdgeInsets.all(5),color: Color(0xff1E429F),),
                        ),
                        SizedBox(width: 4,),
                        Text('5 Days', style: TextStyles.regular14.copyWith(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text.rich(
                      TextSpan(
                        style: TextStyles.regular15,
                        children: [
                          TextSpan(text: 'From '),
                          TextSpan(
                            text: '${widget.tourModel.price}\$',
                            style: TextStyles.semiBold15.copyWith(color: Color(0xff1c64f2)),
                          ),
                          TextSpan(text: ' Per Person'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 14,
                right: 20,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      widget.tourModel.isFav = !widget.tourModel.isFav;
                      getIt<FavoriteLocalDataSource>().toggleFavorite(widget.tourModel);
                      setState((){});
                    },
                    icon: widget.tourModel.isFav
                        ? SvgPicture.asset('assets/icons/heart.svg', )
                        : SvgPicture.asset('assets/icons/favorite.svg',),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}