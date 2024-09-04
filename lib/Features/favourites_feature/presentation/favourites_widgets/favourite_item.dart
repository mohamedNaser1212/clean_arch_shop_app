import 'package:flutter/material.dart';

import '../../../../core/managers/navigations_manager/navigations_manager.dart';
import '../../../../core/models/base_products_model.dart';
import '../../../../core/utils/screens/products_details_screen.dart';
import '../../../../core/utils/widgets/product_info_widget.dart';
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
      padding: const EdgeInsets.all(20.0),
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
          height: 150,
          child: Row(
            children: [
              ProductInfoWidget(model: model),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    ProductInformationWidget(product: model),
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
