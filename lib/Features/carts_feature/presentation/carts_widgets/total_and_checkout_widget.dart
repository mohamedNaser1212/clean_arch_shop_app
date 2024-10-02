import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/check_out_botton.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/total_text_widget.dart';

class TotalAndCheckOutWidget extends StatelessWidget {
  const TotalAndCheckOutWidget({
    super.key,
    required this.total,
  });

  final num total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          TotalTextWidget(total: total),
          const SizedBox(height: 8),
          CheckOutBotton(total: total),
        ],
      ),
    );
  }
}
