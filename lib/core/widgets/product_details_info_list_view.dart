import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_info.dart';
import 'package:shop_app/core/widgets/image_widget.dart';

class ProductDetailsInfoListView extends StatelessWidget {
  ProductDetailsInfoListView({super.key, this.model});
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
        BuildProductDetailsInfo(model: model),
      ],
    );
  }
}
