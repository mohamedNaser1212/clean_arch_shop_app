import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_image_list_view.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody(
      {super.key, required this.model, required this.images, this.isProduct});
  final dynamic model;
  final dynamic isProduct;

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Container _body() {
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
      child: _detailsComponents(),
    );
  }

  Column _detailsComponents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitle(
          title: model.name,
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
          title: model.description,
          style: TitleStyle.style16,
          color: ColorController.accentColor,
        ),
        const SizedBox(height: 8),
        if (model.discount != 0)
          CustomTitle(
            title: 'Discount: ${model.discount}%',
            style: TitleStyle.style18,
            color: ColorController.redAccent,
          ),
        if (model.discount != 0)
          CustomTitle(
            title: 'Old Price: ${model.oldPrice}',
            style: TitleStyle.style18,
            color: ColorController.accentColor,
          ),
        const SizedBox(height: 8),
        CustomTitle(
          title: 'Price: ${model.price}',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
        const SizedBox(height: 16),
        if (isProduct)
          const CustomTitle(
            title: 'Additional Images',
            style: TitleStyle.style20,
            color: ColorController.blackColor,
          ),
        if (isProduct) const SizedBox(height: 8),
        if (isProduct) ProductDetailsImagesListView(images: images),
      ],
    );
  }
}
