import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information_body.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_image_list_view.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class ProductsAdditionalImages extends StatelessWidget {
  const ProductsAdditionalImages({super.key, required this.state});
  final ProductDetailsInformationBodyState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTitle(
          title: 'Additional Images',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
        const SizedBox(height: 8),
        if (state.widget.isProduct)
          ProductDetailsImagesListView(images: state.widget.images),
      ],
    );
  }
}
