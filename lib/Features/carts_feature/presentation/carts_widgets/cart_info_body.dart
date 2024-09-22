import 'package:flutter/widgets.dart';
import 'package:shop_app/Features/favourites_feature/presentation/favourites_widgets/favourite_and_cart_icons.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_information_widget.dart';
import 'package:shop_app/core/models/base_products_model.dart';

class CartsInfoBody extends StatelessWidget {
  const CartsInfoBody({
    super.key,
    required this.model,
  });

  final BaseProductModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProductInformationWidget(product: model),
          const SizedBox(height: 3),
          FavouriteAndCartIcons(product: model),
        ],
      ),
    );
  }
}