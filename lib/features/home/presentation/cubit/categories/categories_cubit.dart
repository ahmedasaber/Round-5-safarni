import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:safarni/features/home/domain/entities/category_entity.dart';
import 'package:safarni/features/home/domain/repositories/categories_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepo) : super(CategoriesInitial());
  final CategoriesRepo categoriesRepo;

  Future<void> loadCategories() async{
    emit(CategoriesLoading());
    final data = await categoriesRepo.getCategories();
    data.fold(
        (failure) => emit(CategoriesFailure(message: failure.message)),
        (categoriesEntity) => emit(CategoriesSuccess(categories: categoriesEntity))
    );
  }
}
