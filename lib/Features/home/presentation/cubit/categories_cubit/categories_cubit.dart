import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/use_case/home_items_use_case/categories_use_case.dart';

import '../../../domain/entities/categories_entity/categories_entity.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.fetchCategoriesUseCase) : super(CategoriesInitial());

  final CategoriesUseCase fetchCategoriesUseCase;

  static CategoriesCubit get(context) => BlocProvider.of(context);

  List<CategoriesEntity>? categoriesModel;

  Future<void> getCategoriesData() async {
    emit(CategoriesLoading());

    final result = await fetchCategoriesUseCase.categoriesCall();
    result.fold(
      (failure) {
        print('Failed to fetch categories: $failure');
        emit(CategoriesError(failure.toString()));
      },
      (categories) {
        categoriesModel = categories;
        emit(CategoriesSuccess(categories));
      },
    );
  }
}
