part of 'payment_cubit.dart';

class PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {}

class PaymentError extends PaymentState {
  final String message;

  PaymentError({
    required this.message,
  });
}
