import 'package:flutter/cupertino.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../cubit/carts_cubit.dart';
import 'cart_screen_builder.dart';

class CartScreenContent extends StatelessWidget {
  const CartScreenContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CartsState state;

  @override
  Widget build(BuildContext context) {
    var cartModel = CartsCubit.get(context).cartEntity;

    if (cartModel.isEmpty) {
      return const Center(
        child: CustomTitle(
          title: 'Sorry, there are no items in your cart',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
      );
    }

    return CartScreenBody(
      cartModel: cartModel,
    );
  }
}
