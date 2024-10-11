import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_details_information_body.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';
import 'package:shop_app/core/models/base_products_model.dart';

class ProductNameWidget extends StatelessWidget {
  const ProductNameWidget({super.key, this.model, this.state});

  final BaseProductModel? model;
  final ProductDetailsInformationBodyState? state;

  @override
  Widget build(BuildContext context) {
    if (model != null) {
      return CustomTitle(
        title: model!.name,
        style: TitleStyle.styleBold18,
        color: ColorController.blackColor,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
    } else if (state != null) {
      return CustomTitle(
        title: state!.widget.model.name,
        style: TitleStyle.style16,
        color: ColorController.blackColor,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
