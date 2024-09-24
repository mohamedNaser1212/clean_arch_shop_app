import 'package:flutter/material.dart';

abstract class NavigationManager {
  const NavigationManager._();
  static void navigateTo({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  static void navigateAndFinish({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );
  }
}
