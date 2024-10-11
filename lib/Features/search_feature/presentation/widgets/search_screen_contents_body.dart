import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/data/search_model/search_model.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class SearchListContentsBody extends StatelessWidget {
  const SearchListContentsBody({
    super.key,
    required this.searchModel,
  });

  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(
          searchModel.image,
          width: 130,
          height: 130,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: CustomTitle(
                title: searchModel.name,
                style: TitleStyle.styleBold18,
                maxLines: 2,
                color: ColorController.blackColor,
              ),
            ),
            const SizedBox(height: 10),
            CustomTitle(
              title: 'Price: ${searchModel.price}',
              style: TitleStyle.style20,
              color: ColorController.redAccent,
            ),
          ],
        ),
      ],
    );
  }
}
