import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_list_content.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../core/widgets/products_details_screen.dart';
import '../../data/search_model/search_model.dart';

class SearchListBody extends StatelessWidget {
  const SearchListBody({
    super.key,
    required this.searchModel,
    required this.resultsList,
  });

  final List<SearchModel> resultsList;
  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: resultsList.isNotEmpty,
      builder: (context) => _buildListContent(context),
      fallback: (context) => const Center(
        child: CustomTitle(
          title: 'No results found',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
      ),
    );
  }

  InkWell _buildListContent(BuildContext context) {
    return InkWell(
      onTap: () => _onSearchItemTap(context), 
      child: SearchListContents(searchModel: searchModel),
    );
  }


  void _onSearchItemTap(BuildContext context) {
    NavigationManager.navigateTo(
      context: context,
      screen: ProductsDetailsScreen(model: searchModel),
    );
  }
}
