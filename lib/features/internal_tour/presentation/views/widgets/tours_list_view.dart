import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/internal_tour/presentation/cubit/Tour_state.dart';
import 'package:safarni/features/internal_tour/presentation/cubit/tour_cubit.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/tours_list_view_item.dart';

class ToursListView extends StatelessWidget {
  const ToursListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TourCubit, TourState>(
        builder: (context, state) {
          if (state is TourLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TourSuccess) {
            final toursList = state.tours;

            return ListView.builder(
              itemCount: toursList.length,
              itemBuilder: (context, index) {
                return ToursListViewItem(tour: toursList[index]);
              },
            );
          } else if (state is TourFailure) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
