part of 'carts_cubit.dart';

class CartsState {}

class GetCartItemsSuccessState extends CartsState {}

class GetCartItemsErrorState extends CartsState {
  final String error;

  GetCartItemsErrorState({
    required this.error,
  });
}

class GetCartItemsLoadingState extends CartsState {}

class AddCartItemsErrorState extends CartsState {
  final String error;

  AddCartItemsErrorState({
    required this.error,
  });
}

class AddToCartSuccessState extends CartsState {
  final List<CartEntity> cartItem;

  AddToCartSuccessState({
    required this.cartItem,
  });
}

class AddCartItemsLoadingState extends CartsState {}

class ChangeCartSuccessState extends CartsState {
  final bool model;

  ChangeCartSuccessState({
    required this.model,
  });
}

class CartEmptyState extends CartsState {}

class ChangeCartLoadingState extends CartsState {}

class ChangeCartErrorState extends CartsState {
  final String error;

  ChangeCartErrorState({
    required this.error,
  });
}

class CheckoutLoadingState extends CartsState {}
