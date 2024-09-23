import 'package:flutter/material.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/product_info_widget.dart';
import 'package:shop_app/core/widgets/products_details_screen.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../home/presentation/products_widgets/products_information_widget.dart';
import 'favourite_and_cart_icons.dart';

class FavoriteItem extends StatelessWidget {
  final BaseProductModel model;

  const FavoriteItem({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          NavigationManager.navigateTo(
            context: context,
            screen: ProductsDetailsScreen(
              model: model,
            ),
          );
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
          child: Row(
            children: [
              ProductImageWidget(model: model),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    ProductInformationWidget(model: model),
                    FavouriteAndCartIcons(model: model),
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
