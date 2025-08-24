import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safarni/features/internal_tour/data/models/tours.dart';
import 'package:safarni/features/internal_tour/presentation/cubit/Tour_state.dart';
import 'package:safarni/features/internal_tour/data/repositories/Tour_repository.dart';

class TourCubit extends Cubit<TourState> {
  final TourRepository tourRepository;

  List<Tour> _allTours = []; 
  List<Tour> _filteredTours = [];

  TourCubit(this.tourRepository) : super(TourInitial());

  Future<void> fetchTours() async {
    try {
      emit(TourLoading());
      final tours = await tourRepository.getAllTours();
      _allTours = tours;
      _filteredTours = tours;
      emit(TourSuccess(_filteredTours));
    } catch (e) {
      emit(TourFailure(e.toString()));
    }
  }

  void searchTours(String query) {
    if (query.isEmpty) {
      _filteredTours = _allTours;
    } else {
      _filteredTours = _allTours
          .where(
            (tour) => tour.title!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    emit(TourSuccess(_filteredTours));
  }
}
