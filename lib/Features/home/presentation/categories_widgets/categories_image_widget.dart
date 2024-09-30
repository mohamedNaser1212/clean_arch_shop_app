import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';

class CategoriesImageWidget extends StatelessWidget {
  const CategoriesImageWidget({
    super.key,
    required this.itemHeight,
    required this.item,
  });

  final double itemHeight;
  final CategoriesEntity item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image(
        width: itemHeight / 1.3,
        height: itemHeight / 1.3,
        fit: BoxFit.cover,
        image: CachedNetworkImageProvider(item.image),
      ),
    );
  }
}
