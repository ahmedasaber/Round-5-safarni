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
import 'package:safarni/features/profile/data/datasourc/profile_remote_data_source.dart';
import 'package:safarni/features/profile/data/datasourc/profile_remote_data_source_impl.dart';
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
import 'package:safarni/core/services/profile_api_service.dart';
import 'package:safarni/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:safarni/features/profile/domain/repositories/profile_repository.dart';
import 'package:safarni/features/profile/presentation/cubit/profile_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt(Box<String> searchHistoryBox) async {
  // Dio instance
  getIt.registerSingleton<Dio>(DioFactory.getDio());

  // Favorites box
  final favoritesBox = Hive.box('favorites');
  getIt.registerSingleton<FavoriteLocalDataSource>(
    FavoriteLocalDataSource(favoritesBox),
  );

  // Search filter history
  getIt.registerSingleton<SearchFilterHistoryDataSource>(
    SearchFilterHistoryDataSource(box: searchHistoryBox),
  );

  // Categories
  getIt.registerSingleton<CategoriesRemoteDataSource>(
    CategoriesRemoteDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerSingleton<CategoriesRepo>(
    CategoriesRepoImpl(
      categoriesRemoteDataSource: getIt<CategoriesRemoteDataSource>(),
    ),
  );

  // Recommendations
  getIt.registerSingleton<RecommendationRemoteDataSource>(
    RecommendationRemoteDataSourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerSingleton<RecommendationRepo>(
    RecommendationRepoImpl(
      recommendationRemoteDataSource: getIt<RecommendationRemoteDataSource>(),
    ),
  );

  // Available Tours
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

  // Search
  getIt.registerSingleton<SearchRemoteDataSource>(
    SearchRemoteDataSourceImpl(
      dio: getIt<Dio>(),
      favoriteLocalDataSource: getIt<FavoriteLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(searchRemoteDataSource: getIt<SearchRemoteDataSource>()),
  );

  // Hotel services
  getIt.registerLazySingleton<HotelApiService>(() => HotelApiService(getIt<Dio>()));
  getIt.registerLazySingleton<HotelRepository>(
    () => HotelRepositoryImpl(getIt()),
  );
  getIt.registerFactory<HotelCubit>(() => HotelCubit(getIt()));
  getIt.registerFactory<RoomDetailCubit>(() => RoomDetailCubit(getIt()));

  // Profile services (simplified setup)
  getIt.registerLazySingleton<ProfileApiService>(
    () => ProfileApiService(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiService: getIt<ProfileApiService>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: getIt<ProfileRemoteDataSource>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(repository: getIt<ProfileRepository>()),
  );
}