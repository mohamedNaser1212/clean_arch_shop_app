part of 'payment_cubit.dart';

class PaymentState {}

class GetClientSecretLoadingState extends PaymentState {}

class GetClientSecretSuccessState extends PaymentState {
  final String clientSecret;

  GetClientSecretSuccessState({required this.clientSecret});
}

class GetClientSecretErrorState extends PaymentState {
  final String message;

  GetClientSecretErrorState({required this.message});
}

class InitializePaymentLoadingState extends PaymentState {}

class InitializePaymentSuccessState extends PaymentState {}

class InitializePaymentErrorState extends PaymentState {
  final String message;

  InitializePaymentErrorState({required this.message});
}
