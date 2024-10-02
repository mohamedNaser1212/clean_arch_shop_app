import 'package:flutter/material.dart';
import '../widgets/build_search_result_list.dart';
import 'build_search_field.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10),
        SearchField(),
        SizedBox(height: 20),
        SearchResultList(), 
        
      ],
    );
  }
}
