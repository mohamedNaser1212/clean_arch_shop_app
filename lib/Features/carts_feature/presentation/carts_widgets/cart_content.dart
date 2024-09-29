import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/empty_cart_text_widget.dart';
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
    var cartModel = CartsCubit.get(context).cartEntity;
    
    if (cartModel.isEmpty) {
      return const EmptyCartTextWidget();
    }
    
    return RefreshIndicatorWidget(cartModel: cartModel);
  }

}


