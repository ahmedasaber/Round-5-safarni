import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/home/domain/repositories/available_tours_repo.dart';

part 'available_ours_state.dart';

class AvailableToursCubit extends Cubit<AvailableToursState> {
  AvailableToursCubit(this.availableToursRepo) : super(AvailableToursInitial());
  final AvailableToursRepo availableToursRepo;

  Future<void> loadAvailableTours() async{
    emit(AvailableToursLoading());
    final data = await availableToursRepo.getAvailableTours();
    data.fold(
        (failure) => emit(AvailableOursFailure(message: failure.message)),
        (availableToursEntity) => emit(AvailableToursSuccess(availableTours: availableToursEntity))
    );
  }
}
