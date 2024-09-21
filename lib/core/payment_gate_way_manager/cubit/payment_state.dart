part of 'payment_cubit.dart';

class PaymentState {}

class PaymentLoading extends PaymentState {}
class PaymentCompleted extends PaymentState {}
class PaymentSuccess extends PaymentState {
  final String clientSecret;

  PaymentSuccess({required this.clientSecret});
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError({required this.message});
}
