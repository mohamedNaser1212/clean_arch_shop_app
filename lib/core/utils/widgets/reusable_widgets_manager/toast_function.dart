import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class ToastWidget extends StatelessWidget {
//   final String message;
//   final bool isError;
//
//   const ToastWidget({
//     super.key,
//     required this.message,
//     required this.isError,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: isError ? Colors.red : Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//     return const SizedBox.shrink();
//   }
// }

void showToast({
  required String message,
  required bool isError,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    fontAsset: 'assets/fonts/Inter_24pt-Medium.ttf',
    backgroundColor: isError ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}