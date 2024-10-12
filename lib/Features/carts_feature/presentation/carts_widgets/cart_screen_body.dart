import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/empty_cart_text_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_refresh_indicator_widget.dart';

import '../cubit/get_carts_cubit/carts_cubit.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartModel = CartsCubit.get(context).cartEntity;
    if (cartModel.isEmpty) {
      return const EmptyCartTextWidget();
    }
    return CartRefreshIndicatorWidget(cartModel: cartModel);
  }
}
