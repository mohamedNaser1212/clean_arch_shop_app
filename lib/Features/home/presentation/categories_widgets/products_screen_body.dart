import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/categories_cubit/categories_cubit.dart';
import '../cubit/products_cubit/get_product_cubit.dart';
import '../cubit/products_cubit/get_products_state.dart';
import '../products_widgets/product_section.dart';

class ProductsScreenBody extends StatelessWidget {
  const ProductsScreenBody({super.key, required this.state});
  final CategoriesState state;
  @override
  Widget build(BuildContext context) {
    final categoriesCubit = CategoriesCubit.get(context);

    if (state is CategoriesSuccess || categoriesCubit.categoriesModel != null) {
      return BlocBuilder<ProductsCubit, GetProductsState>(
        builder: _builder,
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _builder(context, productsState) {
      return ProductSection(state: productsState);
    }
}
