import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/refresh_indicator_widget_builder.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../cubit/carts_cubit.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  const RefreshIndicatorWidget({super.key, required this.cartModel});
  final List<CartEntity> cartModel;
  @override
  Widget build(BuildContext context) {
      return RefreshIndicator(
    onRefresh: () => CartsCubit.get(context).getCarts(),
    child: ConditionalBuilder(
      condition: cartModel.isNotEmpty,
      builder: (context) =>  RefreshIndicatorWidgerBuilder(cartModel: cartModel),
      fallback: (context) => const Center(
        child: LoadingIndicatorWidget(),
      ),
    ),
  );
  }

}

