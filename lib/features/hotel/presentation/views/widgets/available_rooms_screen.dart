import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/core/widgets/custom_loding_widget.dart';
import 'package:safarni/features/hotel/data/models/room_model.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_cubit.dart';
import 'package:safarni/features/hotel/presentation/cubit/hotel_cubit_state.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/custome_app_bar_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/rooms_error_widget.dart';
import 'package:safarni/features/hotel/presentation/views/widgets/rooms_content_widget.dart';

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

  void _retryFetchRooms() {
    context.read<HotelCubit>().fetchAvailableRooms(hotelId: hotelId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: hotelId != null ? 'Hotel Rooms' : 'Available Rooms',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: BlocConsumer<HotelCubit, HotelState>(
        listener: (context, state) {
          if (state is HotelSuccess) {
            _updateRoomsFromState(state.availableRooms);
          }
        },
        builder: (context, state) {
          if (state is HotelLoading) {
            return const CustomLoadingWidget();
          }

          if (state is HotelError) {
            return RoomsErrorWidget(
              errorMessage: state.message,
              onRetry: _retryFetchRooms,
            );
          }

          if (state is HotelSuccess) {
            return RoomsContentWidget(
              hotelId: hotelId,
              filteredRooms: filteredRooms,
              originalRooms: originalRooms,
              currentSearchQuery: currentSearchQuery,
              isSearchActive: isSearchActive,
              onSearchChanged: _filterRooms,
              onClearSearch: _clearSearch,
              onRefresh: _retryFetchRooms,
            );
          }

          return RoomsErrorWidget(
            errorMessage: 'Something went wrong',
            onRetry: _retryFetchRooms,
          );
        },
      ),
    );
  }
}
