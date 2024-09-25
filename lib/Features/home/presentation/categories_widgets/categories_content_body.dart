import 'package:flutter/material.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_image_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_name_widget.dart';
import 'package:shop_app/Features/home/presentation/categories_widgets/categories_widget.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

class CategoriesContentsBody extends StatelessWidget {
  const CategoriesContentsBody({
    super.key,
    required this.state,
  
    required this.item,
  });

  final   CustomCategoriesListViewState state;

  final CategoriesEntity item;

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  Padding _body() {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: state.widget.itemWidth,
      height: state.widget. itemHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorController.accentColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
          CategoriesImageWidget(itemHeight:  state.widget.itemHeight, item: item),
          const SizedBox(width: 10),
          CategoriesNameWidget(item: item),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_rounded)),
        ],
      ),
    ),
  );
  }
}

