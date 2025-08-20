import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_room_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class AvailableRoomsScreenBody extends StatelessWidget {
  const AvailableRoomsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HotelError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: TextStyles.font16LightBlackNormal,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HotelCubit>().fetchAvailableRooms();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is HotelSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarWidget(),
                  verticalSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Rooms',
                        style: TextStyles.font17LightBlackNormal,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View all',
                          style: TextStyles.font15DarkBlueNormal,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),

                  // Check if rooms are available
                  if (state.availableRooms.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text('No rooms available'),
                      ),
                    )
                  else
                    // Rooms Grid
                    GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                      itemCount: state.availableRooms.length,
                      itemBuilder: (context, index) {
                        final room = state.availableRooms[index];
                        return BuildRoomCard(
                          roomName: room.name,
                          price: '\$${room.price.toStringAsFixed(0)}',
                          imageUrl: room.image,
                        );
                      },
                    ),
                ],
              ),
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
