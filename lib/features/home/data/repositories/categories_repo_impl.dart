import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/data/datasources/categories/categories_remote_data_source.dart';
import 'package:safarni/features/home/domain/entities/category_entity.dart';
import 'package:safarni/features/home/domain/repositories/categories_repo.dart';

class CategoriesRepoImpl extends CategoriesRepo{
  final CategoriesRemoteDataSource categoriesRemoteDataSource;

  CategoriesRepoImpl({required this.categoriesRemoteDataSource});
  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async{
    try {
      List<CategoryEntity> list = await categoriesRemoteDataSource.fetchCategories();
      return right(list);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}