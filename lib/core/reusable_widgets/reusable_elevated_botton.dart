import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles/text_styles.dart';

class ReusableElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color backColor;
  final Color textColor;
  final String label;
  final void Function()? onPressed;

  const ReusableElevatedButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.backColor = Colors.blue,
    this.textColor = Colors.white,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: Styles.textStyle20.copyWith(color: textColor, fontSize: 20),
        ),
      ),
    );
  }
}
