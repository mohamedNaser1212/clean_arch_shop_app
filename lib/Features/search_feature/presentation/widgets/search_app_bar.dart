import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => _onPressed(context), 
      ),
      title: const CustomTitle(
        title: 'Search',
        style: TitleStyle.style20,
        color: ColorController.whiteColor,
      ),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.pop(context);
  }

  // Implementing the PreferredSizeWidget interface
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
