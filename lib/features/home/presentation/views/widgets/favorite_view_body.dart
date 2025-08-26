import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extensions.dart';
import 'package:safarni/core/widgets/custom_app_bar.dart';
import 'package:safarni/features/destination/presentation/views/pages/destination_page.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';
import 'package:safarni/features/home/presentation/views/widgets/favorite_item.dart';

// ignore: must_be_immutable
class FavoriteViewBody extends StatefulWidget {
  const FavoriteViewBody({super.key, required this.favoriteLocalDataSource});

  final FavoriteLocalDataSource favoriteLocalDataSource;

  @override
  State<FavoriteViewBody> createState() => _FavoriteViewBodyState();
}

class _FavoriteViewBodyState extends State<FavoriteViewBody> {
  //bool isFavorite = false;
  /*List<FavoriteItem> list = [
    FavoriteItem(
      image: 'assets/images/Eiffel-Tower.jpg',
      location: 'Eiffel Tower',
      price: '230',
      isFavorite: true,
      onPressed: () {},
    ),
    FavoriteItem(
      image: 'assets/images/Double-Dreams-in-Paris.jpg',
      location: 'Double Dreams in Paris',
      price: '1050',
      isFavorite: true,
      onPressed: () {},
    ),
    FavoriteItem(
      image: 'assets/images/River-Cruise.jpg',
      location: 'Evening River Cruise ',
      price: '100',
      isFavorite: true,
      onPressed: () {},
    ),
    FavoriteItem(
      image: 'assets/images/Disneyland-Paris .jpg',
      location: 'Disneyland Paris ',
      price: '280',
      isFavorite: true,
      onPressed: () {},
    ),
  ];*/

  late List<TourModel> favList ;
  @override
  void initState() {
    favList = widget.favoriteLocalDataSource.getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Favorite', automaticallyImplyLeading: false),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 16),
        itemCount: favList.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              context.pushNamed(DestinationView.routeName, arguments: DestinationView(tourModel: favList[i],));
            },
            child: FavoriteItem(
              image: favList[i].image,
              location: favList[i].location,
              price: favList[i].price.toString(),
              isFavorite: favList[i].isFav,
              onPressed: (() {
                favList[i].isFav = !favList[i].isFav;
                widget.favoriteLocalDataSource.toggleFavorite(favList[i]);
                favList = widget.favoriteLocalDataSource.getFavorites();
                setState(() {});
              }),
            ),
          );
        },
      ),
    );
  }
}
