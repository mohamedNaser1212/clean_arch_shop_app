import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/refresh_indicator_widget.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../cubit/carts_cubit.dart';


class CartScreenBody extends StatelessWidget {
  const CartScreenBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CartsState state;

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Widget _body(BuildContext context) {
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
    
    return RefreshIndicatorWidget(cartModel: cartModel);
  }
}
