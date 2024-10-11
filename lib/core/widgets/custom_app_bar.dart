import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeadingIcon;
  Color? backColor = ColorController.primaryColor;
  final Color? textColor;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle; 

  CustomAppBar({
    Key? key,
    required this.title,
    this.showLeadingIcon = true,
    this.backColor,
    this.textColor = ColorController.whiteColor,
    this.leading,
    this.actions,
    this.centerTitle = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor,
      leading: leading ??
          (showLeadingIcon
              ? IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: ColorController.whiteColor),
                  onPressed: () => _onPressed(context: context),
                )
              : null),
      title: CustomTitle(
        title: title,
        style: TitleStyle.styleBold20,
        color: textColor,
      ),
      centerTitle: centerTitle, 
      actions: actions,
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
