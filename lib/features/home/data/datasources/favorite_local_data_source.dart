import 'package:hive/hive.dart';
import 'package:safarni/features/home/data/models/available_tours_model.dart';

class FavoriteLocalDataSource{
  final Box _box;

  FavoriteLocalDataSource(this._box);

  void toggleFavorite(TourModel tourModel){
    if(_box.containsKey(tourModel.id)){
      _box.delete(tourModel.id);
    }else{
      _box.put(tourModel.id, tourModel.toJson());
    }
  }

  List<TourModel> getFavorites(){
    final favList = _box.values
        .map((e) => TourModel.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
    return favList;
  }

  get favIds => _box.keys.toSet();
}