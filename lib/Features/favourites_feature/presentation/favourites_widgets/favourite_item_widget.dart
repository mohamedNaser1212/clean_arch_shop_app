import 'package:flutter/material.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/products_details_widgets/product_image_widget.dart';
import 'package:shop_app/Features/home/presentation/screens/products_details_screen.dart';
import '../../../../core/functions/navigations_function.dart';
import '../../../home/presentation/products_widgets/products_information_widget.dart';
import '../../../../core/widgets/favourites_and_carts_icons/produxts_icons.dart';
import '../../../../core/widgets/custom_sized_box.dart';

class FavoritesItems extends StatelessWidget {
  final BaseProductModel model;

  const FavoritesItems({
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => _onPressed(context),
        child: CustomSizedBox(
          child: Row(
            children: [
              ProductImageWidget(model: model),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProductInformationWidget(model: model),
                    ProductsIcons(model: model),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    NavigationFunctions.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(
        model: model,
        
        
      ),
    );
  }
}
