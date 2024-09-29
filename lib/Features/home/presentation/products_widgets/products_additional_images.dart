import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_body.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_image_list_view.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class ProductsAdditionalImages extends StatelessWidget {
  const ProductsAdditionalImages({super.key, required this.state});
  final ProductDetailsBodyState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTitle(
            title: 'Additional Images',
            style: TitleStyle.style20,
            color: ColorController.blackColor,
          ),
        if (state.widget.isProduct) const SizedBox(height: 8),
        if (state.widget.isProduct)
          ProductDetailsImagesListView(images: state.widget.images),
      ],
    );
  }
}