import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/categories_cubit/categories_cubit.dart';

import '../../../../core/functions/toast_function.dart';
import '../categories_widgets/products_screen_body.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: _listener,
        ),
      ],
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(context, categoriesState) {
        return ProductsScreenBody(state: categoriesState);
      }

  void _listener(context, state) {
          if (state is CategoriesError) {
            showToast(message: state.error, isError: true);
          }
        }
}
