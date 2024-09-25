import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/entities/products_entity/product_entity.dart';
import '../../../Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../Features/home/presentation/cubit/products_cubit/get_products_state.dart';
import '../../../Features/home/presentation/products_widgets/product_details_info.dart';
import '../utils/styles_manager/color_manager.dart';
import '../utils/constants.dart';
import 'custom_title.dart';
import 'image_widget.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final dynamic model;

  const ProductsDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, GetProductsState>(
      listener: _listener,
      builder: _builder, 
    );
  }

  void _listener(context, state) {}

  Widget _builder(BuildContext context, GetProductsState state) {
    final isProduct = model is ProductEntity;
    final image = model.image;
    final images = isProduct ? model.images : [image];

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
          CarousalImageWidget(images: images),
          const SizedBox(height: 16),
          BuildProductDetailsInfo(model: model),
        ],
      ),
    );
  }
}
