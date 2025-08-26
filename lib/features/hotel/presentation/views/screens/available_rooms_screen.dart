import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/available_rooms_screen.dart';

class AvailableRoomsScreen extends StatelessWidget {
  static const routeName = '/available-rooms-screen';
  const AvailableRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int? hotelId = ModalRoute.of(context)?.settings.arguments as int?;
    
    
    return BlocProvider(
      create: (context) {
        return getIt<HotelCubit>()..fetchAvailableRooms(hotelId: hotelId);
      },
      child: AvailableRoomsScreenBody(hotelId: hotelId), 
    );
  }
}