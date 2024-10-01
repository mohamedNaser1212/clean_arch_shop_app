import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/products_components.dart';

import '../cubit/products_cubit/get_product_cubit.dart';
import '../cubit/products_cubit/get_products_state.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({super.key, required this.state});
  final GetProductsState state;
  @override
  Widget build(BuildContext context) {
    final productsCubit = ProductsCubit.get(context);

    if (state is GetProductsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GetproductsSuccessState ||
        productsCubit.homeModel != null) {
      return const ProductsComponenets();
    } else {
      return const Center(child: Text('No products available'));
    }
  }
}
