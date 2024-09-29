import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_info_body.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/widgets/product_info_widget.dart';
import '../../../../core/widgets/products_details_screen.dart';

class CartItemWidget extends StatelessWidget {
  final BaseProductModel model;

  const CartItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () => _onPressed(context, model),
          child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              children: [
                ProductImageWidget(model: model),
                const SizedBox(width: 10),
                CartsInfoBody(model: model),
              ],
            ),
          ),
        ));
  }

  void _onPressed(BuildContext context, BaseProductModel model) {
    NavigationManager.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(model: model),
    );
  }
}
