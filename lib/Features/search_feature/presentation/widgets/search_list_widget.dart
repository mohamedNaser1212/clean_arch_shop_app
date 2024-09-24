import 'package:flutter/material.dart';
import 'package:shop_app/Features/search_feature/presentation/widgets/search_list.dart';

import '../../data/search_model/search_model.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key, required this.resultsList});
  final List<SearchModel> resultsList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _listView(),
    );
  }

  ListView _listView() {
    return ListView.separated(
      itemCount: resultsList.length,
      itemBuilder: (context, index) {
        final result = resultsList[index];
        return SearchListBody(
          searchModel: result,
          resultsList: resultsList,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
