import 'package:flutter/material.dart';
import 'package:safarni/core/helpers/extensions.dart';
import 'package:safarni/features/destination/presentation/views/pages/destination_page.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';
import 'package:safarni/features/home/presentation/views/widgets/favorite_item.dart';

class FavoriteViewBody extends StatefulWidget {
  const FavoriteViewBody({super.key, required this.favoriteLocalDataSource});

  final FavoriteLocalDataSource favoriteLocalDataSource;

  @override
  State<FavoriteViewBody> createState() => _FavoriteViewBodyState();
}

class _FavoriteViewBodyState extends State<FavoriteViewBody> {
  late List<TourModel> favList;

  @override
  void initState() {
    super.initState();
    _refreshFavorites();
  }

  void _refreshFavorites() {
    favList = widget.favoriteLocalDataSource.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            16,
            MediaQuery.of(context).padding.top + 16,
            16,
            16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                'Favorite',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        // Body content
        Expanded(
          child: favList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No favorites yet!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add some tours to your favorites',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 16),
                  itemCount: favList.length,
                  itemBuilder: (context, i) {
                    if (i >= favList.length) {
                      return SizedBox.shrink();
                    }

                    final tour = favList[i];

                    return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          DestinationView.routeName,
                          arguments: DestinationView(tourModel: tour),
                        );
                      },
                      child: FavoriteItem(
                        image: tour.image,
                        location: tour.location,
                        price: tour.price.toString(),
                        isFavorite: tour.isFav,
                        onPressed: () {
                          tour.isFav = !tour.isFav;
                          widget.favoriteLocalDataSource.toggleFavorite(tour);
                          setState(() {
                            _refreshFavorites();
                          });
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
