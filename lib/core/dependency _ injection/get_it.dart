import 'package:get_it/get_it.dart';
import 'package:safarni/features/home/data/datasources/categories_remote_data_source.dart';
import 'package:safarni/features/home/data/datasources/categories_remote_data_source_impl.dart';
import 'package:safarni/features/home/data/datasources/recommendation_remote_data_source.dart';
import 'package:safarni/features/home/data/datasources/recommendation_remote_data_source_impl.dart';
import 'package:safarni/features/home/data/repositories/categories_repo_impl.dart';
import 'package:safarni/features/home/data/repositories/recommendation_repo_impl.dart';
import 'package:safarni/features/home/domain/repositories/categories_repo.dart';
import 'package:safarni/features/home/domain/repositories/recommendation_repo.dart';
import 'package:safarni/features/home/presentation/cubit/recommendation/recommendations_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<CategoriesRemoteDataSource>(CategoriesRemoteDataSourceImpl());
  getIt.registerSingleton<CategoriesRepo>(CategoriesRepoImpl(categoriesRemoteDataSource: getIt<CategoriesRemoteDataSource>()));

  getIt.registerSingleton<RecommendationRemoteDataSource>(RecommendationRemoteDataSourceImpl());
  getIt.registerSingleton<RecommendationRepo>(RecommendationRepoImpl(recommendationRemoteDataSource: getIt<RecommendationRemoteDataSource>()));
}
