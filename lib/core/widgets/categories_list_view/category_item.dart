import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../Features/home/domain/entities/categories_entity/categories_entity.dart';

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
              image: CachedNetworkImageProvider(
                  item.image), // Fixing mixed content
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: whiteColor,
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
