import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_content_body.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_image_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_name_widget.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
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
    return CategoriesContentsBody(itemWidth: itemWidth, itemHeight: itemHeight, item: item);
  }
}

