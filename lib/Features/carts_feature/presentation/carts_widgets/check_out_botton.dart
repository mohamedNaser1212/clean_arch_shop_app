import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_elevated_botton.dart';

class CheckOutBotton extends StatelessWidget {
  const CheckOutBotton({
    super.key,
    required this.total,
  });

  final num total;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.checkOutButton(
      context: context,
      total: total,
    );
  }
}
