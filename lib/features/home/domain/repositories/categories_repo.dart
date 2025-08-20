import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/domain/entities/category_entity.dart';

abstract class CategoriesRepo{
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}