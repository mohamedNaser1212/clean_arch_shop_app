import 'package:flutter/material.dart';

var defaultLightColor = Colors.deepOrange;

double buttonsBoarderRaduis=20;

ThemeData lightTheme=ThemeData(
  appBarTheme: AppBarTheme(
    color: defaultLightColor,
  ),
  iconTheme: IconThemeData(
    color: defaultLightColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 10,
    selectedItemColor: defaultLightColor,
    unselectedItemColor: Colors.black,

  ),
  primaryColor: defaultLightColor,
  primarySwatch: defaultLightColor,
);

TextEditingController emailController=TextEditingController();
TextEditingController passwordController=TextEditingController();

String token='';