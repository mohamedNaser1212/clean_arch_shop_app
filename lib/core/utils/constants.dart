import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

var defaultLightColor = Colors.deepOrange;

double buttonsBoarderRaduis = 20;

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    color: defaultLightColor,
  ),
  iconTheme: IconThemeData(
    color: defaultLightColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 10,
    selectedItemColor: defaultLightColor,
    unselectedItemColor: ColorController.blackColor,
  ),
  primaryColor: defaultLightColor,
  primarySwatch: defaultLightColor,
);

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

// String token='';

Color defaultColor = ColorController.whiteColor;

String fontFamily = 'Inter';
String splashImage = 'assets/images/groot.jpg';
