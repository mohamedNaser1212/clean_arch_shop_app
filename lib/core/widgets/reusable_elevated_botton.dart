import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';
import '../utils/styles_manager/text_styles_manager.dart';

// ignore: must_be_immutable
class ReusableElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  Color? backColor = ColorController.blueAccentColor;
  Color? textColor = ColorController.whiteColor;
  final String label;
  final void Function()? onPressed;

  ReusableElevatedButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.backColor,
    this.textColor,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: StylesManager.textStyle20
              .copyWith(color: textColor, fontSize: 20),
        ),
      ),
    );
  }
}
