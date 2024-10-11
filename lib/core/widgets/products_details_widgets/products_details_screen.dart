import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/custom_app_bar.dart';
import 'package:shop_app/core/widgets/products_details_widgets/product_details_body.dart';
import '../../../Features/home/presentation/cubit/get_products_cubit/get_product_cubit.dart';
import '../../../Features/home/presentation/cubit/get_products_cubit/get_products_state.dart';
import '../../utils/constants.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final BaseProductModel model;

  const ProductsDetailsScreen({
    super.key, 
    required this.model, 
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, GetProductsState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(context, state) {}

  Widget _builder(BuildContext context, GetProductsState state) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product Details',
        centerTitle: true,
        leading: _leadingIcon(context),
      ),
      body: ProductDetailsBody(
        model: model,
      ),
    );
  }

  IconButton _leadingIcon(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: defaultColor),
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).pop();
  }
}
