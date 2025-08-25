// data/repositories/boarding_pass_repository_impl.dart

import '../../domain/entities/boarding_pass_entity.dart';
import '../../domain/repositories/boarding_pass_repository_interface.dart';
import '../datasource/boarding_pass_remote_data_source.dart';

class BoardingPassRepositoryImpl implements BoardingPassRepository {
  final BoardingPassRemoteDataSource remoteDataSource;

  BoardingPassRepositoryImpl(this.remoteDataSource);

  @override
  Future<BoardingPass> getBoardingPass() async {
    return await remoteDataSource.getBoardingPass();
  }
}
