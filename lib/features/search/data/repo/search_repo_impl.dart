import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/search/data/datasource/search_remote_data_source.dart';
import 'package:safarni/features/search/domain/repo/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepoImpl({required this.searchRemoteDataSource});

  @override
  Future<Either<Failure, List<ToursEntity>>> getSearchedTours({
    required String query ,
    required String location ,
    required String minPrice ,
    required String maxPrice ,
    required String minRate ,
    required String sortedBy ,
  }) async {
    try {
      List<ToursEntity> list = await searchRemoteDataSource.fetchSearchedTours(
        query: query,
        location: location,
        maxPrice: maxPrice,
        minPrice: minPrice,
        minRate: minRate,
        sortedBy: sortedBy,
      );
      return right(list);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
