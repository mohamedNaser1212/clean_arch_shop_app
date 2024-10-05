import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class LoadingTextWidget extends StatelessWidget {
  const LoadingTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomTitle(
        title: 'Loading...',
        style: TitleStyle.styleBold18,
      ),
    );
  }
}
