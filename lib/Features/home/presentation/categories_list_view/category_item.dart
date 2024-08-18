import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';

Widget categoryItem(CategoriesEntity item, BuildContext context,
    double? itemHeight, double? itemWidth) {
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
              width: itemHeight! / 1.2,
              height: itemHeight / 1.2,
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(item.image),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorController.whiteColor,
                fontSize: 24,
              ),
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
