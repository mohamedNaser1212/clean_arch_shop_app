import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_list.dart';

import '../../data/search_model/search_model.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key, required this.results});
  final List<SearchModel> results;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return SearchListBody(
            searchModel: result,
            resultsList: results,
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
