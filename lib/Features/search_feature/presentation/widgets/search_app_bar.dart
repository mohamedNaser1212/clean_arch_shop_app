import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_app_bar.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: 'Search',
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
