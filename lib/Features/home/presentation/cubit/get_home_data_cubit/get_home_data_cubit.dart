import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/domain/use_case/home_use_case/categories_use_case.dart';
import 'package:shop_app/Features/home/domain/use_case/home_use_case/products_Use_Case.dart';
import 'get_home_data_state.dart';
class GetHomeDataCubit extends Cubit<GetHomeDataState> {
  GetHomeDataCubit({
    required this.fetchCategoriesUseCase,
    required this.fetchHomeItemsUseCase,
  }) : super(GetHomeDataState());

  static GetHomeDataCubit get(context) => BlocProvider.of(context);

  final CategoriesUseCase fetchCategoriesUseCase;
  final ProductsUseCase fetchHomeItemsUseCase;

  List<ProductEntity> productModel = [];
  List<CategoriesEntity> categoriesModel = [];

  bool _categoriesFetched = false;
  bool _productsFetched = false;

  Future<void> getCategoriesData() async {
    if (_categoriesFetched) return;
    
    emit(CategoriesLoading());
    final result = await fetchCategoriesUseCase.call();
    result.fold(
      (failure) => emit(CategoriesError(error: failure.toString())),
      (categories) {
        categoriesModel = categories;
        _categoriesFetched = true;
        emit(CategoriesSuccess(categories));
      },
    );
  }

  Future<void> getProducts() async {
    if (_productsFetched) return; 
    
    emit(GetProductsLoadingState());
    final result = await fetchHomeItemsUseCase.call();
    result.fold(
      (failure) => emit(GetProductsErrorState(error: failure.toString())),
      (products) {
        productModel = products;
        _productsFetched = true;
        emit(GetproductsSuccessState(products: products));
      },
    );
  }
}
