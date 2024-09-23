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
        onTap: () {
          NavigationManager.navigateTo(
            context: context,
            screen: ProductsDetailsScreen(model: model),
          );
        },
        child: SizedBox(
          height: 150,
          child: Row(
            children: [
              ProductImageWidget(model: model),
              const SizedBox(width: 10),
              CartsInfoBody(model: model),
            ],
          ),
        ),
      ),
    );
  }
}
