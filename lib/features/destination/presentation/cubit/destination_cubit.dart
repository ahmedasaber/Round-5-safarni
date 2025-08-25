import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/destination.dart';
import '../../domain/usecases/get_destination_details.dart';

part 'destination_state.dart';

class DestinationCubit extends Cubit<DestinationState> {
  final GetDestinationDetails getDestinationDetails;

  DestinationCubit(this.getDestinationDetails) : super(DestinationInitial());

  Future<void> fetchDestination(String id) async {
    emit(DestinationLoading());
    try {
      final destination = await getDestinationDetails(id);
      emit(DestinationLoaded(destination));
    } catch (e) {
      emit(DestinationError("Failed to load destination details"));
    }
  }
}
