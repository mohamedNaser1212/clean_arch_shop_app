import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class CategoriesNameWidget extends StatelessWidget {
  const CategoriesNameWidget({
    super.key,
    required this.item,
  });

  final CategoriesEntity item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTitle(
        title: item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TitleStyle.styleBold24,
        color: ColorController.whiteColor,
      ),
    );
  }
}
