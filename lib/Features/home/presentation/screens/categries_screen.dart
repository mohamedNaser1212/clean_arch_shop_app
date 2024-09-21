import 'package:flutter/material.dart';

import '../categories_widgets/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoriesWidget(
      itemHeight: MediaQuery.of(context).size.height / 7,
      itemWidth: double.infinity,
    );
  }
}
