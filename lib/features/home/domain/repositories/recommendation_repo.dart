import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/domain/entities/recommendation_entity.dart';

abstract class RecommendationRepo{
  Future<Either<Failure, List<RecommendationEntity>>> getRecommendations();
}