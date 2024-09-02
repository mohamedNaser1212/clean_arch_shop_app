part of 'toggle_cart_cubit.dart';

class ToggleCartState {}

class ToggleCartItemsErrorState extends ToggleCartState {
  final String error;

  ToggleCartItemsErrorState({
    required this.error,
  });
}

class ToggleCartLoadingState extends ToggleCartState {}

class ToggleCartSuccessState extends ToggleCartState {
  final bool model;

  ToggleCartSuccessState({
    required this.model,
  });
}