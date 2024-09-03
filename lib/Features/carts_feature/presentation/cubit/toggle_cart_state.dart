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

class ChangeCartListSuccessState extends ToggleCartState {
  final bool model;

  ChangeCartListSuccessState({
    required this.model,
  });
}

class ChangeCartListLoadingState extends ToggleCartState {}

class ChangeCartListErrorState extends ToggleCartState {
  final String error;

  ChangeCartListErrorState({
    required this.error,
  });
}
