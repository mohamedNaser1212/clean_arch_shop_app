part of 'carts_cubit.dart';

class CartsState {}

class GetCartItemsSuccessState extends CartsState {}

class GetCartItemsErrorState extends CartsState {
  final String error;

  GetCartItemsErrorState(this.error);
}

class GetCartItemsLoadingState extends CartsState {}

class AddCartItemsErrorState extends CartsState {
  final String error;

  AddCartItemsErrorState(this.error);
}

class AddCartItemsLoadingState extends CartsState {}

class ChangeCartSuccessState extends CartsState {
  final bool model;

  ChangeCartSuccessState(this.model);
}

class ChangeCartLoadingState extends CartsState {}

class ChangeCartErrorState extends CartsState {
  final String? error;

  ChangeCartErrorState([this.error]);
}
