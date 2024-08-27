import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';

import '../../../Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../Features/home/presentation/cubit/products_cubit/get_products_state.dart';
import '../../../Features/home/presentation/products_widgets/product_details_info.dart';
import '../styles_manager/color_manager.dart';
import '../widgets/constants.dart';
import '../widgets/custom_title.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final dynamic model;

  const ProductsDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final isProduct = model is ProductEntity;
    final image = model.image;

    final images = isProduct ? model.images : [image];

    return BlocConsumer<ProductsCubit, GetProductsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const CustomTitle(
              title: 'Product Details',
              style: TitleStyle.style20,
              color: ColorController.whiteColor,
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
