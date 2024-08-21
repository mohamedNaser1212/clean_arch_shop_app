import 'package:flutter/material.dart';

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

// Uncomment and use as needed
// void signout({
//   required BuildContext context,
//   required Widget screen,
// }) {
//   CacheHelper.removeData(key: 'token');
//   navigateAndFinish(
//     context: context,
//     screen: screen,
//   );
// }
