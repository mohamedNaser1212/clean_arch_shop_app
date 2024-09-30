import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorController.primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => _onPressed(context: context),
      ),
      title: CustomTitle(
        title: title,
        style: TitleStyle.styleBold20,
        color: ColorController.whiteColor,
      ),
    );
  }

  void _onPressed({
    required BuildContext context,
  }) {
    Navigator.pop(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
