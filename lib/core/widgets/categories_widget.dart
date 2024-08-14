import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';

import '../../Features/home/presentation/manager/shop_cubit/shop_state.dart';
import 'categories_item_builder.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    this.itemHeight = 100.0,
    this.itemWidth = 100.0,
  });

  final double itemHeight;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).categoriesModel != null,
          builder: (context) {
            var categoryModel = ShopCubit.get(context).categoriesModel;
            return CategoriesItemBuilder(
                categoryModel: categoryModel!,
                context: context,
                itemHeight: itemHeight,
                itemWidth: itemWidth);
          },
          fallback: (context) => const Center(child: Text('Loading...')),
        );
      },
    );
  }
}
