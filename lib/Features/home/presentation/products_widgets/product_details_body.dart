import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody(
      {super.key,
      required this.model,
      required this.name,
      required this.discount,
      required this.price,
      required this.oldPrice,
      required this.images,
      required this.description,
      this.isProduct});
  final dynamic model;
  final dynamic isProduct;
  final String name;
  final num discount;
  final num price;
  final num oldPrice;
  final List<String> images;
  final String description;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(
            title: name,
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
            title: description,
            style: TitleStyle.style16,
            color: ColorController.accentColor,
          ),
          const SizedBox(height: 8),
          if (discount != 0 && discount != null)
            CustomTitle(
              title: 'Discount: $discount%',
              style: TitleStyle.style18,
              color: ColorController.redAccent,
            ),
          if (discount != 0)
            CustomTitle(
              title: 'Old Price: ${oldPrice ?? ''}',
              style: TitleStyle.style18,
              color: ColorController.accentColor,
            ),
          const SizedBox(height: 8),
          CustomTitle(
            title: 'Price: $price',
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
      ),
    );
  }
}

class ProductDetailsImagesListView extends StatelessWidget {
  const ProductDetailsImagesListView({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: images[index],
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
