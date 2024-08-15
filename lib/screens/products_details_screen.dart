import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';
import 'package:shop_app/core/utils/styles/text_styles.dart';
import 'package:shop_app/models/new_get_home_data.dart';

import '../core/widgets/constants.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final dynamic model;

  const ProductsDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isProduct = model is ProductEntity;
    final image = model.image;

    final images = isProduct ? model.images : [image];

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 3,
                    autoPlay: true,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 600),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                  items: images.map<Widget>((img) {
                    return CachedNetworkImage(
                      imageUrl: img,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              BuildProductDetailsInfo(model: model),
            ],
          ),
        );
      },
    );
  }
}

class BuildProductDetailsInfo extends StatelessWidget {
  const BuildProductDetailsInfo({super.key, this.model});
  final dynamic model;
  @override
  Widget build(BuildContext context) {
    final isProduct = model is Products;
    final name = model.name;

    final image = model.image;
    final discount = model.discount;
    final price = model.price;
    final oldPrice = model.oldPrice;
    final images = isProduct ? model.images : [image];
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
          Text(name, style: Styles.textStyle24),
          const SizedBox(height: 8),
          const Text(
            'Description:',
            style: Styles.textStyle20,
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: Styles.textStyle16,
          ),
          const SizedBox(height: 8),
          if (discount != 0 || discount != null)
            Text(
              'Discount: $discount%',
              style: Styles.textStyle18.copyWith(
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          const SizedBox(height: 8),
          Text('Price: $price', style: Styles.textStyle20),
          if (discount != 0)
            Text('Old Price: $oldPrice', style: Styles.textStyle18),
          const SizedBox(height: 16),
          if (isProduct)
            const Text('Additional Images', style: Styles.textStyle20),
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
