import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_body.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_image_list_view.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class ProductsDetailsComponents extends StatelessWidget {
  const ProductsDetailsComponents({super.key, required this.state});
  final ProductDetailsBodyState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(
          title: state.widget.model.name,
          style: TitleStyle.style24,
          color: ColorController.blackColor,
        ),
        const SizedBox(height: 8),
        const CustomTitle(
          title: 'Description:',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
        const SizedBox(height: 4),
        CustomTitle(
          title: state.widget.model.description,
          style: TitleStyle.style16,
          color: ColorController.accentColor,
        ),
        const SizedBox(height: 8),
        if (state.widget.model.discount != 0)
          CustomTitle(
            title: 'Discount: ${state.widget.model.discount}%',
            style: TitleStyle.style18,
            color: ColorController.redAccent,
          ),
        if (state.widget.model.discount != 0)
          CustomTitle(
            title: 'Old Price: ${state.widget.model.oldPrice}',
            style: TitleStyle.style18,
            color: ColorController.accentColor,
          ),
        const SizedBox(height: 8),
        CustomTitle(
          title: 'Price: ${state.widget.model.price}',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
        const SizedBox(height: 16),
        if (state.widget.isProduct)
          const CustomTitle(
            title: 'Additional Images',
            style: TitleStyle.style20,
            color: ColorController.blackColor,
          ),
        if (state.widget.isProduct) const SizedBox(height: 8),
        if (state.widget.isProduct) ProductDetailsImagesListView(images: state.widget.images),
      ],
    );
  }
}
