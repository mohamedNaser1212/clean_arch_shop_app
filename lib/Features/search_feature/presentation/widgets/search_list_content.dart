import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/data/search_model/search_model.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_screen_contents_body.dart';
import 'package:shop_app/core/functions/navigations_function.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
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
        child: SearchListContentsBody(searchModel: searchModel),
      ),
    );
  }

  void _onSearchItemTap(BuildContext context) {
    NavigationFunctions.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(model: searchModel),
    );
  }
}
