import '../entities/boarding_pass_entity.dart';
import '../repositories/boarding_pass_repository_interface.dart';

class GetBoardingPass {
  final BoardingPassRepository repository;

  GetBoardingPass(this.repository);

  Future<BoardingPass> call() async {
    return await repository.getBoardingPass();
  }
}
