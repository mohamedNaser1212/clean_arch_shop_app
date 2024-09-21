import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/favourites_widgets/favourite_and_cart_icons.dart';
import 'package:shop_app/core/models/base_products_model.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/widgets/product_info_widget.dart';
import '../../../../core/widgets/products_details_screen.dart';
import '../../../home/presentation/products_widgets/products_information_widget.dart';

class CartItemWidget extends StatelessWidget {
  final BaseProductModel model;

  const CartItemWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    var cartItem = CartsCubit.get(context).carts[model.id] ?? false;
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
              ProductInfoWidget(model: model),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductInformationWidget(product: model),
                    const SizedBox(height: 3),
                    FavouriteAndCartIcons(product: model),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
