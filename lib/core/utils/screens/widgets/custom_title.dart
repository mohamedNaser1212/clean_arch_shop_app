import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const CustomTitle(
      {required this.title,
      Key? key,
      required this.fontSize,
      required this.fontWeight,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
