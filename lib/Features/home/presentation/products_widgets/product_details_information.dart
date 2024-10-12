import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information_body.dart';
import 'package:shop_app/core/models/base_products_model.dart';

class ProductDetailsInformation extends StatelessWidget {
  const ProductDetailsInformation({super.key, required this.model});
  final BaseProductModel model;

  @override
  Widget build(BuildContext context) {
    final isProduct = model is ProductEntity;
    final images = isProduct
        ? (model.images?.cast<String>() ?? [])
        : [model.image.toString()];
    return ProductDetailsInformationBody(
      model: model,
      images: images,
    );
  }
}
