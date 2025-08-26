import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/utils/app_colors.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/car_booking/presentation/cubit/car_cubit.dart';
import 'package:safarni/features/car_booking/presentation/cubit/car_state.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/info_card.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/plan_card.dart';

class CarDetailsPage extends StatefulWidget {
  final int carId; 

  const CarDetailsPage({super.key, required this.carId});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  @override
  void initState() {
    super.initState();

    context.read<CarBookingCubit>().getCarById(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    context.read<CarBookingCubit>().getCarById(widget.carId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CarBookingCubit, CarBookingState>(
        builder: (context, state) {
          if (state is CarBookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarDetailsLoaded) {
            final car = state.car;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 400.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffF3F4F6),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.r),
                            bottomRight: Radius.circular(16.r),
                          ),
                        ),
                        child: Image.network(
                          car.category?.imageUrl ??
                              "https://via.placeholder.com/300",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/car.png",
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 24),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 24.r,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "${car.brand} ${car.model}",
                      style: TextStyles.font17BlackMedium,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoCard(title: "Fuel", value: car.fuelType ?? "-"),
                        InfoCard(
                          title: "Seats",
                          value: "${car.seats ?? '-'} seats",
                        ),
                        InfoCard(
                          title: "Transmission",
                          value: car.transmission ?? "-",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text("Plan", style: TextStyles.font17BlackMedium),
                  ),
                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: PlanCard(
                            price: "\$${car.dailyRate ?? '0'}",
                            title: "Daily Rent",
                            subtitle: "Pay per day",
                            isSelected: true,
                            icon: "assets/svgs/clock.svg",
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PlanCard(
                            price:
                                "\$${(int.tryParse(car.dailyRate ?? '0') ?? 0) * 7}",
                            title: "Weekly Rent",
                            subtitle: "Save more with a week",
                            isSelected: false,
                            icon: "assets/svgs/clock.svg",
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Location",
                      style: TextStyles.font14BlackMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      initialValue:
                          car.category?.description ?? "No location available",
                      style: TextStyles.font13DarkGreyRegular,
                      decoration: InputDecoration(
                        prefixIcon: SizedBox(
                          width: 30,
                          height: 30,
                          child: SvgPicture.asset(
                            "assets/svgs/location.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffF3F4F6),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: CustomButton(
                      onPressed: () {
                        context.read<CarBookingCubit>().bookCar(
                          car.id!,
                          1, // userId مؤقت
                          "2025-08-25",
                          "2025-08-30",
                        );
                      },
                      text: "Pick up",
                      color: AppColors.blue,
                      textStyle: TextStyles.font16WhiteSemiBold,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CarBookingError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
