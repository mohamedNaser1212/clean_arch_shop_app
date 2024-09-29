import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_body.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';
import 'package:shop_app/core/models/base_products_model.dart'; 

class ProductsPricesWidgets extends StatelessWidget {
  const ProductsPricesWidgets({super.key, this.model,  this.state});

  final BaseProductModel? model; 
  final ProductDetailsBodyState? state;

  @override
  Widget build(BuildContext context) {

    final productModel = model ?? state?.widget.model;

    return Column(
      children: [
        if(model != null) 
        CustomTitle(
          title: 'Discount: ${productModel.discount}%',
          style: TitleStyle.style18,
          color: ColorController.redAccent,
        ),
        if (productModel.discount != 0 && model != null)   
          CustomTitle(
            title: 'Old Price: ${productModel.oldPrice}',
            style: TitleStyle.style18,
            color: ColorController.accentColor,
          ),
       
        if( model != null)
        CustomTitle(
          title: 'Price: ${productModel.price}',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
      ],
    );
  }
}
