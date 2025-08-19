import 'package:flutter/material.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/hotel_item_view_body.dart';

class HotelItemView extends StatelessWidget {
  static const String routeName = '/hotel-item';
  const HotelItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HotelItemViewBody(); // Changed from HotelItemView() to HotelItemViewBody()
  }
}