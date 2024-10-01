import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/Features/home/presentation/products_widgets/product_item.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title_widget.dart';

class ProductItemImage extends StatelessWidget {
  const ProductItemImage({super.key, required this.product});
  final ProductItemState product;
  @override
  Widget build(BuildContext context) {
    return Stack(
    alignment: AlignmentDirectional.bottomStart,
    children: [
      Image(
        image: CachedNetworkImageProvider(
          product.widget.product.image,
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
      ),
      if (product.widget.product.discount != 0)
        Container(
          color: ColorController.primaryColor,
          padding: const EdgeInsets.all(2),
          child: const CustomTitle(
            title: 'DISCOUNT',
            style: TitleStyle.style12,
            color: ColorController.blackColor,
          ),
        ),
    ],
  );
  }


}
