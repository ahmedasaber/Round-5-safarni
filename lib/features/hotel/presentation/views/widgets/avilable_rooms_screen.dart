import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_assets.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_room_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/search_bar_widget.dart';

class AvailableRoomsScreenBody extends StatefulWidget {
  const AvailableRoomsScreenBody({super.key});

  @override
  State<AvailableRoomsScreenBody> createState() =>
      _AvailableRoomsScreenBodyState();
}

class _AvailableRoomsScreenBodyState extends State<AvailableRoomsScreenBody> {
  int? hotelId;

  @override
  void initState() {
    super.initState();
    // Get hotel ID from route arguments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is int) {
        hotelId = args;
        context.read<HotelCubit>().fetchAvailableRooms(hotelId: hotelId);
      } else {
        // If no hotel ID provided, fetch all available rooms
        context.read<HotelCubit>().fetchAvailableRooms();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          hotelId != null ? 'Hotel Rooms' : 'Available Rooms',
          style: TextStyles.font17LightBlackNormal,
        ),
        centerTitle: true,
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
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  verticalSpace(16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyles.font16LightBlackNormal,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HotelCubit>().fetchAvailableRooms(
                        hotelId: hotelId,
                      );
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
                  // Search bar (optional, you can remove if not needed for specific hotel)
                  if (hotelId == null) ...[
                    const SearchBarWidget(),
                    verticalSpace(16),
                  ],

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        hotelId != null
                            ? 'Available Rooms'
                            : 'All Available Rooms',
                        style: TextStyles.font17LightBlackNormal,
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<HotelCubit>().fetchAvailableRooms(
                            hotelId: hotelId,
                          );
                        },
                        child: Text(
                          'Refresh',
                          style: TextStyles.font15DarkBlueNormal,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),

                  if (state.availableRooms.isEmpty)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.hotel_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            verticalSpace(16),
                            Text(
                              hotelId != null
                                  ? 'No rooms available in this hotel today'
                                  : 'No rooms available for today',
                              style: TextStyles.font16LightBlackNormal,
                              textAlign: TextAlign.center,
                            ),
                            verticalSpace(8),
                            Text(
                              'Try selecting a different date or hotel',
                              style: TextStyles.font14DarkGrayNormal,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.availableRooms.length} rooms found',
                          style: TextStyles.font14DarkGrayNormal,
                        ),
                        verticalSpace(12),
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
                              roomId: room.id,
                              roomName: room.name,
                              price: '\$${room.price.toStringAsFixed(0)}',
                              imageUrl: room.image,
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong',
                  style: TextStyles.font16LightBlackNormal,
                ),
                verticalSpace(16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HotelCubit>().fetchAvailableRooms(
                      hotelId: hotelId,
                    );
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
