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



class ChangeCartListSuccessState extends CartsState {
  final bool model;

  ChangeCartListSuccessState({
    required this.model,
  });
}

class ChangeCartListLoadingState extends CartsState {}

class ChangeCartListErrorState extends CartsState {
  final String error;

  ChangeCartListErrorState({
    required this.error,
  });
}
