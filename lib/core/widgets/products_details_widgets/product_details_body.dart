import 'package:flutter/material.dart';

import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/products_details_widgets/carousal_image_widget.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({
    super.key,
    required this.model,
  });

  final BaseProductModel model;

  @override
  Widget build(BuildContext context) {
    final images = model.images?? [model.image];

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CarousalImageWidget(images: images  ),
        const SizedBox(height: 16),
        ProductDetailsInformation(model: model),
      ],
    );
  }
}
