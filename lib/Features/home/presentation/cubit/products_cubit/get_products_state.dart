import '../../../domain/entities/products_entity/product_entity.dart';

abstract class GetProductsState {}

class ProductsInitialState extends GetProductsState {}

class ShopChangeBottomNavState extends GetProductsState {}

class GetproductsSuccessState extends GetProductsState {
  final List<ProductEntity> products;

  GetproductsSuccessState(this.products);
}

class GetProductsLoadingState extends GetProductsState {}

class GetProductsErrorState extends GetProductsState {
  final String? error;

  GetProductsErrorState([this.error]);
}

class ClearProductsState extends GetProductsState {}
