import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';

class CategoriesPageItems extends StatelessWidget {
  const CategoriesPageItems(
      {super.key,
      required this.item,
      required this.context,
      required this.itemHeight,
      required this.itemWidth});
  final CategoriesEntity item;
  final BuildContext context;
  final double itemHeight;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                width: itemHeight / 1.2,
                height: itemHeight / 1.2,
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(item.image),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTitle(
                title: item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TitleStyle.styleBold24,
                color: ColorController.whiteColor,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios_rounded)),
          ],
        ),
      ),
    );
  }
}
