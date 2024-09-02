import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';

import '../../../../core/utils/widgets/constants.dart';

part 'toggle_cart_state.dart';

class ToggleCartCubit extends Cubit<ToggleCartState> {
  ToggleCartCubit({
    required this.toggleCartUseCase,
  }) : super(ToggleCartState());
  final ToggleCartUseCase toggleCartUseCase;

  static ToggleCartCubit get(context) => BlocProvider.of(context);

  Future<void> changeCarts(num prodId) async {
    emit(ToggleCartLoadingState());
    carts[prodId] = !(carts[prodId] ?? false);

    final result = await toggleCartUseCase.call(products: prodId);
    result.fold(
      (failure) {
        print('Failed to add/remove cart items: $failure');
        emit(ToggleCartItemsErrorState(error: failure.message));
        carts[prodId] = !(carts[prodId] ?? false);
      },
      (isAdded) async {
        emit(ToggleCartSuccessState(
          model: carts[prodId] ?? false,
        ));
      },
    );
  }
}
