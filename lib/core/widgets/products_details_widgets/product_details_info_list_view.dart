import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information.dart';
import 'package:shop_app/core/widgets/products_details_widgets/carousal_image_widget.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({super.key, this.model});
  final dynamic model;

  @override
  Widget build(BuildContext context) {
    final isProduct = model is ProductEntity;
    final image = model.image;
    final images = isProduct ? model.images : [image];
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CarousalImageWidget(images: images),
        const SizedBox(height: 16),
        ProductDetailsInformation(model: model),
      ],
    );
  }
}
