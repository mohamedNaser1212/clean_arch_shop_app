import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/categories_entity/categories_entity.dart';
import '../../../domain/use_case/home_use_case/categories_use_case.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({
    required this.fetchCategoriesUseCase,
  }) : super(CategoriesState());

  final FetchCategoriesUseCase fetchCategoriesUseCase;

  static CategoriesCubit get(context) => BlocProvider.of(context);

  List<CategoriesEntity>? categoriesModel;

  Future<void> getCategoriesData() async {
    emit(CategoriesLoading());

    final result = await fetchCategoriesUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch categories: $failure');
        emit(CategoriesError(error: failure.toString()));
      },
      (categories) {
        categoriesModel = categories;
        emit(CategoriesSuccess(categories));
      },
    );
  }
}
