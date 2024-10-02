import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/domain/carts_use_case/toggle_cart_use_case.dart';

import '../../../domain/cart_entity/add_to_cart_entity.dart';
import '../../../domain/carts_use_case/remove_cart_use_case.dart';

part 'toggle_cart_state.dart';

class ToggleCartCubit extends Cubit<ToggleCartState> {
  ToggleCartCubit({
    required this.toggleCartUseCase,
    required this.removeCartUseCase,
  }) : super(ToggleCartState());
  final ToggleCartUseCase toggleCartUseCase;
  final RemoveCartUseCase removeCartUseCase;

  static ToggleCartCubit get(context) => BlocProvider.of(context);

  Future<void> changeCarts(num prodId) async {
    emit(ToggleCartLoadingState());
    //   carts[prodId] = !(carts[prodId] ?? false);

    final result = await toggleCartUseCase.call(products: prodId);
    result.fold(
      (failure) {
        emit(ToggleCartItemsErrorState(error: failure.message));
      },
      (isAdded) async {
        emit(ToggleCartSuccessState(
          model: isAdded,
        ));
        // carts[prodId] ?? false
      },
    );
  }

  List<CartEntity> cartEntity = [];
  Future<bool> changeCartsList(List<num> prodIds) async {
    emit(ChangeCartListLoadingState());

    for (var prodId in prodIds) {
      final result = await removeCartUseCase.call(products: prodId);
      result.fold(
        (failure) {
          emit(ChangeCartListErrorState(error: failure.message));
        },
        (cartItem) async {
          // await getCartItems();
          emit(ChangeCartListSuccessState(model: true));
        },
      );
    }
    return true;
  }
}
