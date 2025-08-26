import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/car_booking/data/models/car.dart';
import 'package:safarni/features/car_booking/data/repositories/car_repo.dart';
import 'package:safarni/features/car_booking/presentation/cubit/car_cubit.dart';
import 'package:safarni/features/car_booking/presentation/views/pages/car_details.dart';
import 'package:safarni/features/car_booking/data/data_sources/car_remote_data_source.dart';

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${car.brand} ${car.model}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        car.transmission ?? "",
                        style: TextStyles.font14GreyRegular,
                      ),
                      const SizedBox(width: 4),
                      Text('|', style: TextStyles.font14LightGreyRegular),
                      const SizedBox(width: 4),
                      Text(
                        "${car.seats ?? ""} Seats",
                        style: TextStyles.font14GreyRegular,
                      ),
                      const SizedBox(width: 4),
                      Text('|', style: TextStyles.font14LightGreyRegular),
                      const SizedBox(width: 4),
                      Text(
                        car.fuelType ?? "",
                        style: TextStyles.font14GreyRegular,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        onPressed: () {},
                        color: AppColors.blue,
                        text: "Rent Now",
                        textStyle: TextStyles.font16WhiteSemiBold,
                      ),
                      SizedBox(width: 18.w),
                      CustomButton(
                        borderColor: AppColors.blue,
                        color: Colors.white,
                        textStyle: TextStyles.font16BlueSemiBold,

                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (_) =>
                                    CarBookingCubit(
                                      CarRepositoryImpl(
                                        CarRemoteDataSourceImpl(Dio()),
                                      ),
                                    )..getCarById(
                                      car.id!,
                                    ), 
                                child: CarDetailsPage(carId: car.id!),
                              ),
                            ),
                          );
                        },

                        text: "Detail",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: -60,
            right: -10,
            child: Image.network(
              car.category?.imageUrl ?? "",
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/car_test.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
