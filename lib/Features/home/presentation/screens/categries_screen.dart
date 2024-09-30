import 'package:flutter/material.dart';

import '../categories_widgets/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoriesScreenBody(
      isHorizontal: false,
      itemHeight: MediaQuery.of(context).size.height / 5,
      itemWidth: double.infinity,
    );
  }
}
