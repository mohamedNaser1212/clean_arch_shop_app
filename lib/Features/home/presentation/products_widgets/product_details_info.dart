import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';

import '../../../../core/utils/styles/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';

class BuildProductDetailsInfo extends StatelessWidget {
  const BuildProductDetailsInfo({super.key, this.model});
  final dynamic model;

  @override
  Widget build(BuildContext context) {
    final isProduct = model is ProductEntity;
    final name = model.name;
    final discount = model.discount;
    final price = model.price;
    final oldPrice = model.oldPrice;
    final images = isProduct ? model.images : [model.image];
    final description = model.description ?? 'No description available';

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
            color: Colors.black,
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
              color: ColorController.blackColor,
            ),
          const SizedBox(height: 8),
          CustomTitle(
            title: 'Price: $price',
            style: TitleStyle.style20,
            color: ColorController.blackColor,
          ),
          if (discount != 0)
            CustomTitle(
              title: 'Old Price: ${oldPrice ?? ''}',
              style: TitleStyle.style18,
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
          if (isProduct)
            SizedBox(
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
            ),
        ],
      ),
    );
  }
}
