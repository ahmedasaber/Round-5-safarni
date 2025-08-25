import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:safarni/core/services/dio_factory.dart';
import 'package:safarni/core/services/hotel_api_services.dart';
import 'package:safarni/features/hotel/data/repositories/hotel_repository.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel_about/presentation/cubit/room_detail_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<HotelApiService>(() => HotelApiService(dio));
  getIt.registerLazySingleton<HotelRepository>(
    () => HotelRepositoryImpl(getIt()),
  );
  getIt.registerFactory<HotelCubit>(() => HotelCubit(getIt()));
  getIt.registerFactory<RoomDetailCubit>(() => RoomDetailCubit(getIt()));
}
