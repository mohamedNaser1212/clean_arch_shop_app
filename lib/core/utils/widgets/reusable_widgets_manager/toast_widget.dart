import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  final bool isError;

  const ToastWidget({
    super.key,
    required this.message,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    return const SizedBox.shrink();
  }
}
