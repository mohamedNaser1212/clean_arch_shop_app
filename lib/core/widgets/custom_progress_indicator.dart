import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles/color_manager.dart';

class BlockInteractionLoadingWidget extends StatelessWidget {
  const BlockInteractionLoadingWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: ColorController.blackColor.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorController.blackColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
