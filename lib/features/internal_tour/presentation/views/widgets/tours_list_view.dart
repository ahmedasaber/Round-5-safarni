import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/internal_tour/presentation/cubit/destination_cubit.dart';
import 'package:safarni/features/internal_tour/presentation/views/widgets/tours_list_view_item.dart';

class ToursListView extends StatelessWidget {
  const ToursListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<DestinationCubit, DestinationState>(
        builder: (context, state) {
          if (state is DestinationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DestinationSuccess) {
            return ListView.builder(
              itemCount: state.destinations.length,
              itemBuilder: (context, index) {
                final destination = state.destinations[index];
                return ToursListViewItem(destination: destination);
              },
            );
          } else if (state is DestinationFailure) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
