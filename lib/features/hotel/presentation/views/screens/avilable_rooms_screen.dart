import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';

class AvailableRoomsScreen extends StatelessWidget {
  static const routeName = '/available-rooms-screen';
  const AvailableRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استقبال hotel ID من الـ arguments
    final int? hotelId = ModalRoute.of(context)?.settings.arguments as int?;
    
    print('🎯 AvailableRoomsScreen - Received hotel ID: $hotelId'); // Debug print
    
    return BlocProvider(
      create: (context) {
        print('🔧 Creating HotelCubit and calling fetchAvailableRooms with hotelId: $hotelId'); // Debug print
        return getIt<HotelCubit>()..fetchAvailableRooms(hotelId: hotelId);
      },
      child: AvailableRoomsScreenBody(hotelId: hotelId), // تمرير hotelId للـ body
    );
  }
}