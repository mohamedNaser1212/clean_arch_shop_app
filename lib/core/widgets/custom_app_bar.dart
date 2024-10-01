import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  Color? backColor = ColorController.primaryColor;
  Color? textColor = ColorController.whiteColor;

  CustomAppBar({
    Key? key,
    required this.title,
    this.backColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => _onPressed(context: context),
      ),
      title: CustomTitle(
        title: title,
        style: TitleStyle.styleBold20,
        color: textColor,
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
