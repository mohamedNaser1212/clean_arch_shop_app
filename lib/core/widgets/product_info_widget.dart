import 'package:flutter/material.dart';

import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/cached_network_image_widget.dart';

import 'custom_title.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, required this.model});
  final BaseProductModel model;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        CachedNetworkImageWidget(model: model),
        if (model.discount != 0)
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(2),
            child: const CustomTitle(
              title: 'DISCOUNT',
              style: TitleStyle.style14,
            ),
          ),
      ],
    );
  }
}
