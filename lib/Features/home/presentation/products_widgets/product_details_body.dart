import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_details_components.dart';


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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
