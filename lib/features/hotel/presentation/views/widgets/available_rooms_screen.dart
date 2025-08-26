import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/helpers/spacing.dart';
import 'package:safarni/core/utils/app_styles.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/build_room_card.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/room_search_bart_widget.dart';

class AvailableRoomsScreenBody extends StatefulWidget {
  final int? hotelId;

  const AvailableRoomsScreenBody({super.key, this.hotelId});

  @override
  State<AvailableRoomsScreenBody> createState() =>
      _AvailableRoomsScreenBodyState();
}

class _AvailableRoomsScreenBodyState extends State<AvailableRoomsScreenBody> {
  int? get hotelId => widget.hotelId;
  List<RoomModel> originalRooms = [];
  List<RoomModel> filteredRooms = [];
  String currentSearchQuery = '';
  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
  }

  void _filterRooms(String query) {
    setState(() {
      currentSearchQuery = query.trim();
      isSearchActive = currentSearchQuery.isNotEmpty;

      if (currentSearchQuery.isEmpty) {
        filteredRooms = originalRooms;
      } else {
        filteredRooms = originalRooms.where((room) {
          return room.name.toLowerCase().contains(
            currentSearchQuery.toLowerCase(),
          );
        }).toList();
      }
    });

  }

  void _clearSearch() {
    setState(() {
      currentSearchQuery = '';
      isSearchActive = false;
      filteredRooms = originalRooms;
    });
  }

  void _updateRoomsFromState(List<RoomModel> newRooms) {
    setState(() {
      originalRooms = newRooms;

      if (isSearchActive && currentSearchQuery.isNotEmpty) {
        filteredRooms = originalRooms.where((room) {
          return room.name.toLowerCase().contains(
            currentSearchQuery.toLowerCase(),
          );
        }).toList();
      } else {
        filteredRooms = originalRooms;
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
      body: BlocConsumer<HotelCubit, HotelState>(
        listener: (context, state) {
          if (state is HotelSuccess) {
            _updateRoomsFromState(state.availableRooms);
          }
        },
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

            String roomsTitle = 'Available Rooms';
            if (isSearchActive && currentSearchQuery.isNotEmpty) {
              roomsTitle = 'Search Results for "$currentSearchQuery"';
            } else if (hotelId != null) {
              roomsTitle = 'Available Rooms';
            } else {
              roomsTitle = 'All Available Rooms';
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocalRoomSearchWidget(
                    hotelId: hotelId,
                    onSearchChanged: _filterRooms,
                    onClearSearch: _clearSearch,
                  ),
                  verticalSpace(16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          roomsTitle,
                          style: TextStyles.font17LightBlackNormal,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isSearchActive) ...[
                        TextButton(
                          onPressed: _clearSearch,
                          child: Text(
                            'Clear Search',
                            style: TextStyles.font15DarkBlueNormal,
                          ),
                        ),
                      ] else ...[
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
                    ],
                  ),
                  verticalSpace(16),

                  if (filteredRooms.isEmpty) ...[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              isSearchActive
                                  ? Icons.search_off
                                  : Icons.hotel_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            verticalSpace(16),
                            Text(
                              _getEmptyRoomsMessage(),
                              style: TextStyles.font16LightBlackNormal,
                              textAlign: TextAlign.center,
                            ),
                            verticalSpace(8),
                            Text(
                              _getEmptyRoomsSubtitle(),
                              style: TextStyles.font14DarkGrayNormal,
                              textAlign: TextAlign.center,
                            ),
                            if (isSearchActive) ...[
                              verticalSpace(16),
                              ElevatedButton(
                                onPressed: _clearSearch,
                                child: const Text('Show All Rooms'),
                              ),
                            ] else if (hotelId != null &&
                                originalRooms.isEmpty) ...[
                              verticalSpace(16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Try Another Hotel'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSearchActive
                              ? '${filteredRooms.length} rooms found for "$currentSearchQuery"'
                              : '${filteredRooms.length} rooms found',
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
                          itemCount: filteredRooms.length,
                          itemBuilder: (context, index) {
                            final room = filteredRooms[index];
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

  String _getEmptyRoomsMessage() {
    if (isSearchActive && currentSearchQuery.isNotEmpty) {
      return 'No rooms found for "$currentSearchQuery"';
    } else if (hotelId != null) {
      return 'No rooms available in this hotel today';
    } else {
      return 'No rooms available for today';
    }
  }

  String _getEmptyRoomsSubtitle() {
    if (isSearchActive) {
      return 'Try searching with different keywords or clear the search to see all available rooms.';
    } else if (hotelId != null) {
      return 'This hotel has no available rooms for today. Please check back later or try a different date.';
    } else {
      return 'No rooms are currently available. Try selecting a different date.';
    }
  }
}
