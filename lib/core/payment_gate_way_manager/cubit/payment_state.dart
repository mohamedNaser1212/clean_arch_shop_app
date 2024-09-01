part of 'payment_cubit.dart';

class PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final List<CartEntity> model;

  PaymentSuccess({
    required this.model,
  });
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError({
    required this.message,
  });
}
