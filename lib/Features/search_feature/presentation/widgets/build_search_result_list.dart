import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_list_widget.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../cubit/search_cubit/search_cubit.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = SearchCubit.get(context).searchResults!;
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
