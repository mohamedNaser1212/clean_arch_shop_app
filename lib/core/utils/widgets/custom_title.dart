import 'package:flutter/material.dart';

import '../styles/text_styles.dart';

// Define an enum for the text styles
enum TitleStyle {
  style12,
  style14,
  style16,
  style18,
  styleBold18,
  style20,
  styleBold20,
  style24,
  style30
}

class CustomTitle extends StatelessWidget {
  final String title;
  final TitleStyle style;
  final Color? color; // Allow color to be optional

  const CustomTitle({
    required this.title,
    Key? key,
    required this.style,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Map the enum to the corresponding text style from the Styles class
    TextStyle textStyle;
    switch (style) {
      case TitleStyle.style14:
        textStyle = Styles.textStyle14.copyWith(color: color);
        break;
      case TitleStyle.style12:
        textStyle = Styles.textStyle12.copyWith(color: color);
        break;
      case TitleStyle.style16:
        textStyle = Styles.textStyle16.copyWith(color: color);
        break;
      case TitleStyle.style18:
        textStyle = Styles.textStyle18.copyWith(color: color);
        break;
      case TitleStyle.styleBold18:
        textStyle = Styles.textStyleBold18.copyWith(color: color);
        break;
      case TitleStyle.style20:
        textStyle = Styles.textStyle20.copyWith(color: color);
        break;
      case TitleStyle.styleBold20:
        textStyle = Styles.textStyleBold20.copyWith(color: color);
        break;
      case TitleStyle.style24:
        textStyle = Styles.textStyle24.copyWith(color: color);
        break;
      case TitleStyle.style30:
        textStyle = Styles.textStyle30.copyWith(color: color);
        break;
    }

    return Text(
      title,
      style: textStyle,
    );
  }
}
