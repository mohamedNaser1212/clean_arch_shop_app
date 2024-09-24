import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_body.dart';

class BuildProductDetailsInfo extends StatelessWidget {
  const BuildProductDetailsInfo({super.key, this.model});
  final dynamic model;

  @override
  Widget build(BuildContext context) {
    final isProduct = model is ProductEntity;
    final images = isProduct
        ? (model.images?.cast<String>() ?? [])
        : [model.image.toString()];
    return ProductDetailsBody(
      model: model,
      images: images,
      isProduct: isProduct,
    );
  }
}
