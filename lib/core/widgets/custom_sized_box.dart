import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final Widget child;

  const CustomSizedBox({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: child,
    );
  }
}
