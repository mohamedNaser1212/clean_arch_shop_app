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
