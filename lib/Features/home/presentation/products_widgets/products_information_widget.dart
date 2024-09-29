import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_name_widget.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_prices_widgets.dart';

import 'package:shop_app/core/models/base_products_model.dart';



class ProductInformationWidget extends StatelessWidget {
  const ProductInformationWidget({super.key, required this.model});
  final BaseProductModel model;

  @override
  Widget build(BuildContext context) {
       return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ProductNameWidget(model: model),  
      ProductsPricesWidgets(model: model),
    ],
  );
  }

 
}
