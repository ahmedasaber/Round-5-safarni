part of 'room_detail_cubit.dart';

abstract class RoomDetailState {}

class RoomDetailInitial extends RoomDetailState {}

class RoomDetailLoading extends RoomDetailState {}

class RoomDetailSuccess extends RoomDetailState {
  final RoomDetailModel roomDetail;
  RoomDetailSuccess(this.roomDetail);
}

class RoomDetailError extends RoomDetailState {
  final String message;
  RoomDetailError(this.message);
}
