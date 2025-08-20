import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/data/datasources/recommendation_remote_data_source.dart';
import 'package:safarni/features/home/domain/entities/recommendation_entity.dart';
import 'package:safarni/features/home/domain/repositories/recommendation_repo.dart';

class RecommendationRepoImpl extends RecommendationRepo{
  final RecommendationRemoteDataSource recommendationRemoteDataSource;

  RecommendationRepoImpl({required this.recommendationRemoteDataSource});
  @override
  Future<Either<Failure, List<RecommendationEntity>>> getRecommendations() async{
   try {
     List<RecommendationEntity> list  = await recommendationRemoteDataSource.fetchRecommended();
     return right(list);
   } on Exception catch (e) {
     return left(ServerFailure(e.toString()));
   }
  }

}