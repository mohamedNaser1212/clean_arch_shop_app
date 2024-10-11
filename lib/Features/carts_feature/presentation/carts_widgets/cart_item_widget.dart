import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_info_body.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import '../../../../core/functions/navigations_function.dart';
import '../../../../core/widgets/products_details_widgets/product_image_widget.dart';
import '../../../../core/widgets/products_details_widgets/products_details_screen.dart';
import '../../../../core/widgets/custom_sized_box.dart';

class CartItemWidget extends StatelessWidget {
  final BaseProductModel model;

  const CartItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () => _onPressed(context, model),
        child: CustomSizedBox( 
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

  void _onPressed(BuildContext context, BaseProductModel model) {
    NavigationFunctions.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(model: model, isProductEntity: false),
    );
  }
}
