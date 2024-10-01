import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class TotalTextWidget extends StatelessWidget {
  const TotalTextWidget({
    super.key,
    required this.total,
  });

  final num total;

  @override
  Widget build(BuildContext context) {
    return CustomTitle(
      title: 'Total: \$${total.toStringAsFixed(2)}',
      style: TitleStyle.styleBold20,
    );
  }
}
