import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_use_case/fetch_cart_use_case.dart';
import '../../domain/carts_use_case/remove_cart_use_case.dart';
import '../../domain/carts_use_case/toggle_cart_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit({
    required this.fetchCartUseCase,
    required this.removeCartUseCase,
    required this.toggleCartUseCase,
  }) : super(CartsState());
  final FetchCartUseCase fetchCartUseCase;
  final RemoveCartUseCase removeCartUseCase;
  final ToggleCartUseCase toggleCartUseCase;

  static CartsCubit get(context) => BlocProvider.of(context);

  List<CartEntity> cartModel = [];
  Map<num, bool> carts = {};
  Future<void> getCartItems() async {
    emit(GetCartItemsLoadingState());

    final result = await fetchCartUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch cart items: $failure');
        emit(GetCartItemsErrorState(error: failure.message));
      },
      (cartItems) {
        cartModel = cartItems;
        carts = {for (var p in cartItems) p.id: true};
        emit(GetCartItemsSuccessState());
      },
    );
  }

  Future<void> changeCarts(num prodId) async {
    emit(ChangeCartLoadingState());
    carts[prodId] = !(carts[prodId] ?? false);
    emit(ChangeCartSuccessState(model: carts[prodId] ?? false));

    final result = await toggleCartUseCase.call(products: prodId);
    result.fold(
      (failure) {
        print('Failed to add/remove cart items: $failure');
        emit(AddCartItemsErrorState(error: failure.toString()));
      },
      (isAdded) async {
        await getCartItems();
        emit(ChangeCartSuccessState(
          model: carts[prodId] ?? false,
        ));
      },
    );
  }

  Future<bool> changeCartsList(List<num> prodIds) async {
    emit(ChangeCartLoadingState());

    for (var prodId in prodIds) {
      final result = await removeCartUseCase.call(products: prodId);
      result.fold(
        (failure) {
          print('Failed to remove cart items: $failure');
          emit(AddCartItemsErrorState(error: failure.toString()));
        },
        (cartItem) async {
          await getCartItems();
          emit(AddToCartSuccessState(cartItem: cartItem));
        },
      );
    }
    return true;
  }

  num get cartSubtotal {
    return cartModel.fold(0, (sum, item) => sum + (item.price ?? 0));
  }

  num get cartTotal => cartSubtotal;
}
