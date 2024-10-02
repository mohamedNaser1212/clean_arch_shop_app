import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/products_cubit/get_products_state.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_screem_body.dart';

import '../../../../core/functions/toast_function.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      builder: _builder,
      listener: _listener,
    );
  }

  Widget _builder(context, categoriesState) {
    final categoriesCubit = CategoriesCubit.get(context);

    if (categoriesState is CategoriesSuccess ||
        categoriesCubit.categoriesModel != null) {
      return BlocBuilder<ProductsCubit, GetProductsState>(
        builder: (context, state) => ProductsScreenBody(state: state),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

void _listener(context, state) {
  if (state is CategoriesError) {
    ToastFunction. showToast(
      message: state.error,
    );
  }
}
