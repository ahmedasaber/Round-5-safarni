import 'package:flutter/material.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/car_card.dart';
import 'package:safarni/features/car_booking/presentation/views/widgets/car_brand_item.dart';
import 'package:safarni/features/home/presentation/views/widgets/custom_search_text_field.dart';

class CarBookingPage extends StatelessWidget {
  const CarBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(),
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
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CarBrandItem(
                      name: 'Mercedes',
                      logo: "assets/images/logo_car_test.png",
                      count: "+32",
                    ),
                  );
                },
                itemCount: 10,
                shrinkWrap: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text("Popular cars", style: TextStyles.font17BlackMedium),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: CarCard(
                  name: "S 500 Sedan",
                  driveMode: "Automatic",
                  fuelType: "Diesel",
                  numberOfSeats: "5 Seats",
                  carImage: "assets/images/car_test.png",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
