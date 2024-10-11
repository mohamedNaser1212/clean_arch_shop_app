import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTitle(
      title: 'Description:',
      style: TitleStyle.style20,
      color: ColorController.blackColor,
    );
  }
}
