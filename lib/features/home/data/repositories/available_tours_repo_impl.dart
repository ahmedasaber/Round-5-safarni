import 'package:dartz/dartz.dart';
import 'package:safarni/core/errors/failures.dart';
import 'package:safarni/features/home/data/datasources/available%20tours/available_tours_remote_data_source.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/home/domain/repositories/available_tours_repo.dart';

class AvailableToursRepoImpl extends AvailableToursRepo{
  final AvailableToursRemoteDataSource availableToursRemoteDataSource;

  AvailableToursRepoImpl({required this.availableToursRemoteDataSource});
  @override
  Future<Either<Failure, List<ToursEntity>>> getAvailableTours() async{
    try {
      List<ToursEntity> list = await availableToursRemoteDataSource.fetchAvailableTours();
      return right(list);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

}