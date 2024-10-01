import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/custom_title_widget.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   return const Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CustomTitle(
        title: 'LOGIN Screen',
        style: TitleStyle.style14,
      ),
       CustomTitle(
       title:  'login now to browse our hot offers',
        style: TitleStyle.style14,
      ),
    ],
  );
  }

 
}
