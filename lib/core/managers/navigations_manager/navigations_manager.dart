import 'package:flutter/material.dart';

abstract class NavigationManager {
  void navigateTo({
    required BuildContext context,
    required Widget screen,
  });

  void navigateAndFinish({
    required BuildContext context,
    required Widget screen,
  });
}

class NavigationManagerImpl implements NavigationManager {
  @override
  void navigateTo({
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

  @override
  void navigateAndFinish({
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
