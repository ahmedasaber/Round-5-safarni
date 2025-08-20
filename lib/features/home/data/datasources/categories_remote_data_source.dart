import 'package:safarni/features/home/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource{
  Future<List<CategoryModel>> fetchCategories();
}
