import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/utils/routes.dart';
import 'package:safarni/features/booking_flight/presentation/view/flight_booking_view.dart';
import 'package:safarni/features/home/domain/entities/category_entity.dart';
import 'package:safarni/features/home/presentation/views/widgets/cusrom_category_item.dart';
import 'package:safarni/features/hotel/presentation/views/screens/hotel_item_view.dart';

class ListOfCategories extends StatelessWidget {
  const ListOfCategories({
    super.key, required this.categories,
  });

  final List<CategoryEntity> categories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 97,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (i) {
          return GestureDetector(
            onTap: (){
              if(i == 3){
                context.pushNamed(HotelItemView.routeName);
              }else if(i == 2){
                context.pushNamed(Routes.internalTourPage);
              } else if(i == 1){
                context.pushNamed(Routes.carBookingPage);
              } else if(i == 0){
                context.pushNamed(FlightBookingView.routeName);
              }
            },
            child: CustomCategoryItem(
              categoryImage: categories[i].image,
              categoryTitle: categories[i].title.split(' ').first,
            ),
          );
        }
        ),
      ),
    );
  }
}