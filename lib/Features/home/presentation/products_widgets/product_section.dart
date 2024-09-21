import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_screen_body.dart';

import '../cubit/products_cubit/get_product_cubit.dart';
import '../cubit/products_cubit/get_products_state.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.state});
  final GetProductsState state;
  @override
  Widget build(BuildContext context) {
    final productsCubit = ProductsCubit.get(context);

    if (state is GetProductsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GetproductsSuccessState ||
        productsCubit.homeModel != null) {
      return const ProductsScreenBody();
    } else {
      return const Center(child: Text('No products available'));
    }
  }
}
