import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/data/search_model/search_model.dart';
import 'package:shop_app/core/functions/navigations_functions.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';
import 'package:shop_app/core/widgets/products_details_screen.dart';

class SearchListContents extends StatelessWidget {
  const SearchListContents({
    super.key,
    required this.searchModel,
  });

  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onSearchItemTap(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: ColorController.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorController.dividerColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              searchModel.image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: CustomTitle(
                    title: searchModel.name,
                    style: TitleStyle.style20,
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
        ),
      ),
    );
  }

  void _onSearchItemTap(BuildContext context) {
    NavigationManager.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(model: searchModel),
    );
  }
}
