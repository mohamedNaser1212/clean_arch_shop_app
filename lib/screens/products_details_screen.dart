import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Features/home/domain/entities/products_entity/product_entity.dart';
import '../core/widgets/constants.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final dynamic model; // This can be either ProductEntity or FavouritesEntity

  ProductsDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isProduct = model is ProductEntity;

    final image = isProduct ? model.image : model.image;
    final name = isProduct ? model.name : model.name;
    final discount = isProduct ? model.discount : model.discount;
    final price = isProduct ? model.price : model.price;
    final oldPrice = isProduct ? model.oldPrice : model.oldPrice;
    final images = isProduct ? model.images : [];
    final description = (isProduct ? model.description : model.description) ??
        'No description available';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(
            color: defaultColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: defaultColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CachedNetworkImage(
            imageUrl: image,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Description: $description',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (discount != 0)
            Text(
              'Discount: $discount%',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(height: 8),
          Text(
            'Price: $price',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (discount != 0)
            Text(
              'Old Price: $oldPrice',
              style: const TextStyle(
                fontSize: 14,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          const SizedBox(height: 16),
          if (isProduct)
            const Text(
              'Additional Images',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
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
                    child: CachedNetworkImage(
                      imageUrl: images[index],
                      width: 100,
                      fit: BoxFit.cover,
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
