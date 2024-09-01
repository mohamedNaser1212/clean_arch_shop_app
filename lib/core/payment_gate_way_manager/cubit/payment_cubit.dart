import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/payment_gate_way_manager/domain/payment_use_case/payment_use_case.dart';

import '../../../Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required this.paymentUseCase,
  }) : super(PaymentState());

  static PaymentCubit get(BuildContext context) => BlocProvider.of(context);

  final PaymentUseCase paymentUseCase;

  Future<void> makePayment(int amount, String currency, BuildContext context,
      List<CartEntity> model) async {
    emit(PaymentLoading());
    final result =
        await paymentUseCase.makePayment(amount, currency, context, model);
    result.fold(
      (failure) {
        emit(PaymentError(message: failure.message));
      },
      (success) {
        emit(PaymentSuccess(model: model));
      },
    );
  }
}
