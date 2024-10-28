import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:shop_app/Features/home/presentation/cubit/get_home_data_cubit/get_home_data_state.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_item.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';

import '../../domain/entities/products_entity/product_entity.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataCubit, GetHomeDataState>(
      builder: (context, state) {
        return Container(
          color: ColorController.greyColor.withOpacity(0.1),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.99,
            children: List.generate(
              products.length,
              (index) => ProductItem(
                product: GetHomeDataCubit.get(context).productModel[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
