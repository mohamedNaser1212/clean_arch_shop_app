import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../core/widgets/custom_title.dart';

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
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          CustomTitle(
            title: 'Description:',
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 4),
          CustomTitle(
            title: description,
            fontSize: 16,
            color: blackColor,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(height: 8),
          if (discount != 0 && discount != null)
            CustomTitle(
              title: 'Discount: $discount%',
              fontSize: 18,
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
          const SizedBox(height: 8),
          CustomTitle(
            title: 'Price: $price',
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
          ),
          if (discount != 0)
            CustomTitle(
              title: 'Old Price: ${oldPrice ?? ''}',
              fontSize: 18,
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
          const SizedBox(height: 16),
          if (isProduct)
            CustomTitle(
              title: 'Additional Images',
              fontSize: 20,
              color: blackColor,
              fontWeight: FontWeight.w500,
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
