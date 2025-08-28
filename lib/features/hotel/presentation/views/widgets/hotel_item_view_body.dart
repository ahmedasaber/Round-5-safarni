import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/widgets/custom_loding_widget.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/hotel_app_bar_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/hotel_search_loading_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/hotel_error_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/hotel_success_content_widget.dart';

class HotelItemViewBody extends StatefulWidget {
  const HotelItemViewBody({super.key});

  @override
  State<HotelItemViewBody> createState() => _HotelItemViewBodyState();
}

class _HotelItemViewBodyState extends State<HotelItemViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<HotelCubit>().fetchAllHotelsData();
  }

  void _retryFetchData() {
    context.read<HotelCubit>().fetchAllHotelsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HotelAppBarWidget(),
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return const CustomLoadingWidget();
          }

          if (state is HotelSearchLoading) {
            return const HotelSearchLoadingWidget();
          }

          if (state is HotelError) {
            return HotelErrorWidget(
              errorMessage: state.message,
              onRetry: _retryFetchData,
            );
          }

          if (state is HotelSuccess) {
            return HotelSuccessContentWidget(state: state);
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
