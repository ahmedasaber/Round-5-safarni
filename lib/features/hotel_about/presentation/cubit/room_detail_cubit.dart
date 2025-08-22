import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/hotel/data/repositories/hotel_repository.dart';
import 'package:safarni/features/hotel_about/data/model/room_detail_model.dart';

part 'room_detail_state.dart';

class RoomDetailCubit extends Cubit<RoomDetailState> {
  final HotelRepository _hotelRepository;

  RoomDetailCubit(this._hotelRepository) : super(RoomDetailInitial());

  Future<void> getRoomDetails(int roomId) async {
    emit(RoomDetailLoading());
    try {
      final response = await _hotelRepository.getRoomDetails(roomId);
      emit(RoomDetailSuccess(response.data));
    } catch (e) {
      emit(RoomDetailError(e.toString()));
    }
  }
}