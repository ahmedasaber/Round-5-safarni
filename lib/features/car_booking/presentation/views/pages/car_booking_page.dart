import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/car_booking/data/repositories/car_repo.dart';
import 'package:safarni/features/car_booking/presentation/cubit/car_cubit.dart';
import 'package:safarni/features/car_booking/presentation/cubit/car_state.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/car_card.dart';
import 'package:safarni/features/car_booking/data/data_sources/car_remote_data_source.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/car_brand_item.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_search_text_field.dart';

class CarBookingPage extends StatelessWidget {
  const CarBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CarBookingCubit(CarRepositoryImpl(CarRemoteDataSourceImpl(Dio())))
            ..loadCars(),
      child: const CarBookingView(),
    );
  }
}

class CarBookingView extends StatelessWidget {
  const CarBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSearchTextField(),
          Container(
            width: double.infinity,
            height: 200.h,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset("assets/images/car.jpg", fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text("Brands", style: TextStyles.font17BlackMedium),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 120.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: SizedBox(
                height: 120.h,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: BlocBuilder<CarBookingCubit, CarBookingState>(
                    builder: (context, state) {
                      if (state is CarsBookingLoaded) {
                        final cars = state.cars;

                        final brands = cars
                            .map((c) => c.brand)
                            .toSet()
                            .toList();

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: brands.length,
                          itemBuilder: (context, index) {
                            final brand = brands[index];
                            final brandCars = cars
                                .where((c) => c.brand == brand)
                                .toList();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: CarBrandItem(
                                name: brand ?? "Unknown",
                                logo:
                                    brandCars.first.category?.imageUrl ??
                                    "assets/images/logo_car_test.png",
                                count: "+${brandCars.length}",
                              ),
                            );
                          },
                        );
                      } else if (state is CarBookingLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text("Popular cars", style: TextStyles.font17BlackMedium),
          ),

          Expanded(
            child: BlocBuilder<CarBookingCubit, CarBookingState>(
              builder: (context, state) {
                if (state is CarBookingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CarsBookingLoaded) {
                  final cars = state.cars;
                  return ListView.builder(
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: CarCard(car: cars[index]),
                      );
                    },
                  );
                } else if (state is CarBookingError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
