import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';

import '../../../domain/entities/products_entity/product_entity.dart';


 class GetHomeDataState {}


class ShopChangeBottomNavState extends GetHomeDataState {}

class GetproductsSuccessState extends GetHomeDataState {
  final List<ProductEntity> products;

  GetproductsSuccessState({
    required this.products,
  });
}

class GetProductsLoadingState extends GetHomeDataState {}

class GetProductsErrorState extends GetHomeDataState {
  final String error;

  GetProductsErrorState({
    required this.error,
  });
}

class CategoriesLoading extends GetHomeDataState {}

class CategoriesSuccess extends GetHomeDataState {
  final List<CategoriesEntity> categories;

  CategoriesSuccess(this.categories);
}

class CategoriesError extends GetHomeDataState {
  final String error;

  CategoriesError({
    required this.error,
  });
}
