import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extentions.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/destination/presentation/views/pages/detination_page.dart';
import 'package:safarni/features/home/presentation/views/widgets/favorite-item.dart';
import 'package:safarni/features/internal_tour/presentation/views/pages/destination_page.dart';

// ignore: must_be_immutable
class FavoriteViewBody extends StatelessWidget {
   FavoriteViewBody({
    super.key,
  });

  List<FavoriteItem> list = [
    FavoriteItem(image: 'assets/images/Eiffel-Tower.jpg', location: 'Eiffel Tower', price: '230', isFavorite: true,),
    FavoriteItem(image: 'assets/images/Double-Dreams-in-Paris.jpg', location: 'Double Dreams in Paris', price: '1050', isFavorite: true,),
    FavoriteItem(image: 'assets/images/River-Cruise.jpg', location: 'Evening River Cruise ', price: '100', isFavorite: true,),
    FavoriteItem(image: 'assets/images/Disneyland-Paris .jpg', location: 'Disneyland Paris ', price: '280', isFavorite: true,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Favorite',automaticallyImplyLeading: false,),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 16),
        itemCount: list.length,
        itemBuilder: (context, i){
          return GestureDetector(
            onTap:(){
              context.pushNamed(DestinationView.routeName);
            },child: list[i]);
        }
      ),
    );
  }
}
