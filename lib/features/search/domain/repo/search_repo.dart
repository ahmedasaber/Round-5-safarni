import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<ToursEntity>>> getSearchedTours({
    required String query ,
    required String location ,
    required String minPrice ,
    required String maxPrice ,
    required String minRate ,
    required String sortedBy ,
  });
}
