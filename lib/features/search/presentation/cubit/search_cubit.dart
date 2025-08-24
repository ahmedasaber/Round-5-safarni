import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:safarni/features/home/domain/entities/available_tours_entity.dart';
import 'package:safarni/features/search/domain/repo/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());

  final SearchRepo searchRepo;

  Future<void> searchTours(String query) async{
    emit(SearchLoading());
    final data = await searchRepo.getSearchedTours(query);
    data.fold(
      (failure) => emit(SearchError(message: failure.message)),
      (searchedEntities) => emit(SearchSuccess(toursEntity: searchedEntities))
    );
  }
}
