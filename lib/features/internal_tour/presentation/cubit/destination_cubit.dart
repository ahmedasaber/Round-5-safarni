import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/internal_tour/data/models/destination.dart';
import 'package:safarni/features/internal_tour/data/repositories/destination_repository.dart';



part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  final DestinationRepository repository;

  DestinationCubit(this.repository) : super(DestinationInitial());

  Future<void> fetchDestinations() async {
    emit(DestinationLoading());
    try {
      final destinations = await repository.getAllDestinations();
      emit(DestinationSuccess(destinations));
    } catch (e) {
      emit(DestinationFailure(e.toString()));
    }
  }
}
