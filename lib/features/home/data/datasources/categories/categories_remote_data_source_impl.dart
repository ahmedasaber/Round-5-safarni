import 'package:dio/dio.dart';
import 'package:safarni/features/home/data/datasources/categories/categories_remote_data_source.dart';
import 'package:safarni/features/home/data/models/category_model.dart';

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource{
  final Dio dio;

  CategoriesRemoteDataSourceImpl({required this.dio});
  @override
  Future<List<CategoryModel>> fetchCategories() async{
    try {
      Response response = await dio.get('http://round5-safarnia.huma-volve.com/api/allcategory');
      if(response.statusCode == 200){
        final List data = response.data['data'];
        return data.map((category) => CategoryModel.fromJson(category)).toList();
      }else{
        throw Exception('Failed to load the Categories');
      }
    } on Exception {
      throw Exception('Response Failed');
    }
  }

}