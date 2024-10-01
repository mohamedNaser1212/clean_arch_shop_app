import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/product_details_info_list_view.dart';
import '../../../Features/home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../Features/home/presentation/cubit/products_cubit/get_products_state.dart';
import '../utils/styles_manager/color_manager.dart';
import '../utils/constants.dart';
import 'custom_title_widget.dart';


class ProductsDetailsScreen extends StatelessWidget {
  final dynamic model;

  const ProductsDetailsScreen({super.key, required this.model});

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
      appBar: AppBar(
        title: const CustomTitle(
          title: 'Product Details',
          style: TitleStyle.style20,
          color: ColorController.whiteColor,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: defaultColor),
          onPressed: () => _onPressed(context),
        ),
      ),
      body: ProductDetailsInfoListView(model: model),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).pop();
  }
}
