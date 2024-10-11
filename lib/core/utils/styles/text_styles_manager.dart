import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';

abstract class StylesManager {
  const StylesManager._();
  static final textStyle12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );
  static final textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );

  static final textStyle16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );
  static final textStyle16Bold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );

  static final textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );
  static final textStyleBold18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );
  static final textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );
  static final textStyleBold20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ColorController.blackColor,
    fontFamily: fontFamily,
  );
  static final textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
    color: ColorController.blackColor,
    letterSpacing: 1.2,
  );
  static final textStyleBold24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
    color: ColorController.blackColor,
    letterSpacing: 1.2,
  );
  static final textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    fontFamily: fontFamily,
    color: ColorController.blackColor,
    letterSpacing: 1.2,
  );
}
