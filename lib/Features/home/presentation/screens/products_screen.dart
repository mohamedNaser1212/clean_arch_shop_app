import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_categories_cubit/categories_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_products_cubit/get_product_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_products_cubit/get_products_state.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/productss_screen_body.dart';
import '../../../../core/functions/toast_function.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: _listener,
      builder: (context, categoriesState) {
        final categoriesCubit = CategoriesCubit.get(context);

        if (categoriesState is CategoriesSuccess ||
            categoriesCubit.categoriesModel != null) {
          return BlocConsumer<ProductsCubit, GetProductsState>(
            listener: _productsListener,
            builder: _productsBuilder,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _productsBuilder(context, state) {
    if (state is GetProductsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GetproductsSuccessState) {
      return const ProductsScreenBody();
    } else {
      return const Center(
        child: Text('No products available'),
      );
    }
  }

  void _productsListener(context, state) {
    if (state is GetProductsErrorState) {
      ToastFunction.showToast(
        message: state.error!,
      );
    }
  }

  void _listener(BuildContext context, CategoriesState state) {
    if (state is CategoriesError) {
      ToastFunction.showToast(
        message: state.error,
      );
    }
  }
}
