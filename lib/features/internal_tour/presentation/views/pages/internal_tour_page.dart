import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safarni/features/internal_tour/presentation/cubit/tour_cubit.dart';
import 'package:safarni/features/internal_tour/data/repositories/Tour_repository.dart';
import 'package:safarni/features/internal_tour/data/data_sources/tour_data_source_impl.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/tours_list_view.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/tours_search_bar.dart';

class InternalTourPage extends StatelessWidget {
  const InternalTourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TourCubit(TourRepository(TourRemoteDataSourceImpl(Dio())))..fetchTours(), // هنا استدعاء مبدئي للبيانات
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              ToursSearchBar(),
              Expanded(child: ToursListView()),
            ],
          ),
        ),
      ),
    );
  }
}
