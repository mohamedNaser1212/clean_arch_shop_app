import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_details_components.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody(
      {super.key, required this.model, required this.images, this.isProduct});
  final dynamic model;
  final dynamic isProduct;

  final List<String> images;

  @override
  State<ProductDetailsBody> createState() => ProductDetailsBodyState();
}

class ProductDetailsBodyState extends State<ProductDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorController.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorController.greyColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ProductsDetailsComponents(
        state: this,
      ),
    );
  }
}
