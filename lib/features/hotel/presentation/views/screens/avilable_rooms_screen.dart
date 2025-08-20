import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/avilable_rooms_screen.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_room_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class AvailableRoomsScreen extends StatelessWidget {
  static const routeName = '/available-rooms-screen';
  const AvailableRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HotelCubit>()..fetchAvailableRooms(),
      child: const AvailableRoomsScreenBody(),
    );
  }
}