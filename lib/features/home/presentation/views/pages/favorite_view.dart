import 'package:flutter/material.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/presentation/views/widgets/favorite_view_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  static const routeName = '/favorite';
  @override
  Widget build(BuildContext context) {
    return FavoriteViewBody(favoriteLocalDataSource: getIt<FavoriteLocalDataSource>());
  }
}
