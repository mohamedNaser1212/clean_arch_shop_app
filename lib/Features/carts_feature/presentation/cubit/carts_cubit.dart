import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/screens/widgets/end_points.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_use_case/get_cart_use_case.dart';
import '../../domain/carts_use_case/remove_cart_use_case.dart';
import '../../domain/carts_use_case/toggle_cart_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit(
      this.addToCartUseCase, this.removeFromCartUseCase, this.toggleCartUseCase)
      : super(CartsInitial());
  final FetchCartUseCase addToCartUseCase;
  final RemoveCartUseCase removeFromCartUseCase;
  final ToggleCartUseCase toggleCartUseCase;

  static CartsCubit get(context) => BlocProvider.of(context);

  List<AddToCartEntity> cartModel = [];

  Future<void> getCartItems() async {
    emit(GetCartItemsLoadingState());

    final result = await addToCartUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch cart items: $failure');
        emit(GetCartItemsErrorState(failure.message));
      },
      (cartItems) {
        cartModel = cartItems;
        carts = {for (var p in cartItems) p.id!: true};
        emit(GetCartItemsSuccessState());
      },
    );
  }

  Future<void> changeCarts(num prodId) async {
    emit(ChangeCartLoadingState());
    carts[prodId] = !(carts[prodId] ?? false);
    emit(ChangeCartSuccessState(carts[prodId] ?? false));

    final result = await toggleCartUseCase.toggleCartCall(prodId);
    result.fold(
      (failure) {
        print('Failed to add/remove cart items: $failure');
        emit(AddCartItemsErrorState(failure.toString()));
      },
      (isAdded) async {
        await getCartItems();
        emit(ChangeCartSuccessState(carts[prodId] ?? false));
      },
    );
  }

  changeCartsList(List<num> prodIds) async {
    emit(ChangeCartLoadingState());

    try {
      bool allRemoved = true;

      for (var prodId in prodIds) {
        final result = await removeFromCartUseCase.removeFromCartCall(prodId);
        if (result.isLeft()) {
          print('Failed to remove item with id $prodId');
          allRemoved = false; // Mark as false if any item fails to be removed
        }
      }

      if (allRemoved) {
        // Remove from cache
        for (var prodId in prodIds) {
          carts.remove(prodId);
        }

        // Update product list
        cartModel.removeWhere((item) => prodIds
            .contains(item.id)); // Ensure items are removed from cartModel

        emit(ChangeCartSuccessState(allRemoved));
      } else {
        emit(AddCartItemsErrorState(
            "Failed to remove some items from the cart"));
      }

      return allRemoved; // Ensure a boolean is returned
    } catch (e) {
      print('Error in changeCartsList: $e');
      emit(AddCartItemsErrorState(e.toString()));
      return false; // Return false if an exception occurs
    }
  }

  num get cartSubtotal {
    return cartModel.fold(0, (sum, item) => sum + (item.price ?? 0));
  }

  num get cartTotal => cartSubtotal;
}
