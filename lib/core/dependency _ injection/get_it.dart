import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:safarni/features/home/data/datasources/available%20tours/available_tours_remote_data_source.dart';
import 'package:safarni/features/home/data/datasources/available%20tours/available_tours_remote_data_source_impl.dart';
import 'package:safarni/features/home/data/datasources/categories/categories_remote_data_source.dart';
import 'package:safarni/features/home/data/datasources/categories/categories_remote_data_source_impl.dart';
import 'package:safarni/features/home/data/datasources/favorite_local_data_source.dart';
import 'package:safarni/features/home/data/datasources/recommendation/recommendation_remote_data_source.dart';
import 'package:safarni/features/home/data/datasources/recommendation/recommendation_remote_data_source_impl.dart';
import 'package:safarni/features/home/data/repositories/available_tours_repo_impl.dart';
import 'package:safarni/features/home/data/repositories/categories_repo_impl.dart';
import 'package:safarni/features/home/data/repositories/recommendation_repo_impl.dart';
import 'package:safarni/features/home/domain/repositories/available_tours_repo.dart';
import 'package:safarni/features/home/domain/repositories/categories_repo.dart';
import 'package:safarni/features/home/domain/repositories/recommendation_repo.dart';
import 'package:safarni/features/search/data/datasource/search_filter_history/search_filter_history.dart';
import 'package:safarni/features/search/data/datasource/search_remote_data_source.dart';
import 'package:safarni/features/search/data/datasource/search_remote_data_source_impl.dart';
import 'package:safarni/features/search/data/repo/search_repo_impl.dart';
import 'package:safarni/features/search/domain/repo/search_repo.dart';
import 'package:safarni/core/services/dio_factory.dart';
import 'package:safarni/core/services/hotel_api_services.dart';
import 'package:safarni/features/hotel/data/repositories/hotel_repository.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel_about/presentation/cubit/room_detail_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt(Box<String> searchHistoryBox) async{
  getIt.registerSingleton<Dio>(Dio());

  final favoritesBox = Hive.box('favorites');
  getIt.registerSingleton<FavoriteLocalDataSource>(
    FavoriteLocalDataSource(favoritesBox),
  );

  getIt.registerSingleton<SearchFilterHistoryDataSource>(
    SearchFilterHistoryDataSource(box: searchHistoryBox),
  );

  getIt.registerSingleton<CategoriesRemoteDataSource>(
    CategoriesRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerSingleton<CategoriesRepo>(
    CategoriesRepoImpl(
      categoriesRemoteDataSource: getIt<CategoriesRemoteDataSource>(),
    ),
  );

  getIt.registerSingleton<RecommendationRemoteDataSource>(
    RecommendationRemoteDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerSingleton<RecommendationRepo>(
    RecommendationRepoImpl(
      recommendationRemoteDataSource: getIt<RecommendationRemoteDataSource>(),
    ),
  );

  getIt.registerSingleton<AvailableToursRemoteDataSource>(
    AvailableToursRemoteDataSourceImpl(
      dio: getIt<Dio>(),
      favoriteLocalDataSource: getIt<FavoriteLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<AvailableToursRepo>(
    AvailableToursRepoImpl(
      availableToursRemoteDataSource: getIt<AvailableToursRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<SearchRemoteDataSource>(
    SearchRemoteDataSourceImpl(
      dio: getIt<Dio>(),
      favoriteLocalDataSource: getIt<FavoriteLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(searchRemoteDataSource: getIt<SearchRemoteDataSource>()),
  );

  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<HotelApiService>(() => HotelApiService(dio));
  getIt.registerLazySingleton<HotelRepository>(
    () => HotelRepositoryImpl(getIt()),
  );
  getIt.registerFactory<HotelCubit>(() => HotelCubit(getIt()));
  getIt.registerFactory<RoomDetailCubit>(() => RoomDetailCubit(getIt()));
}
