import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/search/data/datasource/search_remote_data_source.dart';
import 'package:safarni/features/search/domain/repo/search_repo.dart';

class SearchRepoImpl extends SearchRepo{
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepoImpl({required this.searchRemoteDataSource});
  @override
  Future<Either<Failure, List<ToursEntity>>> getSearchedTours(String query) async{
    try {
      List<ToursEntity> list = await searchRemoteDataSource.fetchSearchedTours(query);
      return right(list);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}