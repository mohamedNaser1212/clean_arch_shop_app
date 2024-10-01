import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles_manager/color_manager.dart';

// ignore: must_be_immutable
class ReusableTextFormField extends StatelessWidget {
  final String label;
  final double borderRadius;
  final Color activeColor;
  final Color borderSideColor;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Icon? prefix;
  final IconButton? suffix;
  final bool obscure;

  const ReusableTextFormField({
    Key? key,
    required this.label,
    this.borderRadius = 25,
    this.activeColor = ColorController.blueAccent,
    this.borderSideColor = ColorController.greyColor,
    this.validator,
    this.onSubmit,
    required this.controller,
    required this.keyboardType,
    this.prefix,
    this.suffix,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        validator: validator,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: prefix,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 2.0,
                color: borderSideColor ?? ColorController.greyColor),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: activeColor, width: 2.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
