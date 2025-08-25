// domain/repositories/boarding_pass_repository.dart
import '../entities/boarding_pass_entity.dart';

abstract class BoardingPassRepository {
  Future<BoardingPass> getBoardingPass();
}
