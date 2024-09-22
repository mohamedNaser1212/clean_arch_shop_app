import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}