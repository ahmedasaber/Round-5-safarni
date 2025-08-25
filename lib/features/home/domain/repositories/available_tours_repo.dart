import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';

abstract class AvailableToursRepo{
  Future<Either<Failure,List<ToursEntity>>> getAvailableTours();
}