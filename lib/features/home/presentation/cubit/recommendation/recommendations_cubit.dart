import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safarni/features/home/domain/entities/recommendation_entity.dart';
import 'package:safarni/features/home/domain/repositories/recommendation_repo.dart';

part 'recommendations_state.dart';

class RecommendationsCubit extends Cubit<RecommendationsState> {
  RecommendationsCubit(this.recommendationRepo) : super(RecommendationsInitial());
  final RecommendationRepo recommendationRepo;

  Future<void> loadRecommendations()async{
    final data = await recommendationRepo.getRecommendations();
    data.fold(
        (failure) => emit(RecommendationsFailure(message: failure.message)),
        (recommendationsEntity) => emit(RecommendationsSuccess(recommendations: recommendationsEntity))
    );
  }
}
