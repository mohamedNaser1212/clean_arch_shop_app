import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/core/payment_gate_way_manager/domain/payment_use_case/payment_use_case.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.paymentUseCase}) : super(PaymentState());

  static PaymentCubit get(BuildContext context) => BlocProvider.of(context);

  final PaymentUseCase paymentUseCase;

  Future<void> makePayment({
    required int amount,
    required String currency,
  }) async {
    emit(PaymentLoading());

    final result = await paymentUseCase.getClientSecret(
      amount: amount,
      currency: currency,
    );

    result.fold(
      (failure) {
        emit(PaymentError(message: failure.message));
      },
      (clientSecret) {
        emit(PaymentSuccess(clientSecret: clientSecret));
      },
    );
  }

  Future<void> initializePayment({
    required String clientSecret,
  }) async {
    emit(PaymentLoading());

    final initResult =
        await paymentUseCase.initializePaymentSheet(clientSecret: clientSecret);

    initResult.fold(
      (failure) {
        emit(PaymentError(message: failure.message));
      },
      (success) async {
        
          emit(PaymentCompleted()); 
      
      },
    );
  }
}
