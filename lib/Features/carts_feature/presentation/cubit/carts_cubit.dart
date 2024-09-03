import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/constants.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../domain/carts_use_case/fetch_cart_use_case.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit({
    required this.fetchCartUseCase,
    //required this.removeCartUseCase,
  }) : super(CartsState());
  final FetchCartUseCase fetchCartUseCase;

  static CartsCubit get(context) => BlocProvider.of(context);

  List<CartEntity> cartEntity = [];

  Future<void> getCartItems() async {
    emit(GetCartItemsLoadingState());

    final result = await fetchCartUseCase.call();
    result.fold(
      (failure) {
        print('Failed to fetch cart items: $failure');
        emit(GetCartItemsErrorState(error: failure.message));
      },
      (cartItems) {
        cartEntity = cartItems;

        carts = {for (var p in cartItems) p.id: true};
        emit(GetCartItemsSuccessState());
      },
    );
  }

  num get cartSubtotal {
    return cartEntity.fold(0, (sum, item) => sum + (item.price ?? 0));
  }

  num get cartTotal => cartSubtotal;
}
