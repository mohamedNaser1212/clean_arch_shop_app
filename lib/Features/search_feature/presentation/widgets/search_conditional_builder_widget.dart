import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/data/search_model/search_model.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_list_widget.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class SearchConditionalBuilderWidget extends StatelessWidget {
  const SearchConditionalBuilderWidget({
    super.key,
    required this.results,
  });

  final List<SearchModel> results;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConditionalBuilder(
          condition: results.isNotEmpty,
          builder: (context) => SearchListWidget(resultsList: results),
          fallback: (context) => const Center(
            child: CustomTitle(
              title: 'Sorry, No results found',
              style: TitleStyle.style20,
              color: ColorController.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
