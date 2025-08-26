part of 'recommendations_cubit.dart';

@immutable
sealed class RecommendationsState {}

final class RecommendationsInitial extends RecommendationsState {}
final class RecommendationsLoading extends RecommendationsState {}
final class RecommendationsSuccess extends RecommendationsState {
  final List<ToursEntity> recommendations;

  RecommendationsSuccess({required this.recommendations});
}
final class RecommendationsFailure extends RecommendationsState {
  final String message;

  RecommendationsFailure({required this.message});
}
