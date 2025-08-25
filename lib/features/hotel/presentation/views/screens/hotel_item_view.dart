import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/dependency%20_%20injection/get_it.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/hotel_item_view_body.dart';

class HotelItemView extends StatelessWidget {
  static const String routeName = '/hotel-item';
  const HotelItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HotelCubit>(),
      child: const HotelItemViewBody(),
    );
  }
}
