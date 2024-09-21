import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';

class CategoriesContents extends StatelessWidget {
  const CategoriesContents(
      {super.key,
      required this.item,
      required this.itemHeight,
      required this.itemWidth});
  final CategoriesEntity item;

  final double itemHeight;
  final double itemWidth;
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
