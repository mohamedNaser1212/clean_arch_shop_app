import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_list_widget.dart';

import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../cubit/search_cubit/search_cubit.dart';

class BuildSearchResultList extends StatelessWidget {
  const BuildSearchResultList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = SearchCubit.get(context).searchResults!;
    return ConditionalBuilder(
      condition: results.isNotEmpty,
      builder: (context) => SearchListWidget(results: results),
      fallback: (context) => const Center(
        child: CustomTitle(
          title: 'Sorry, No results found',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
      ),
    );
  }
}
