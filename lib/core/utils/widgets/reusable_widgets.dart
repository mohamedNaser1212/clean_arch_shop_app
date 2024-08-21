import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/styles/text_styles.dart';

class ReusableElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color backColor;
  final Color textColor;
  final String label;
  final void Function()? onPressed;

  const ReusableElevatedButton({
    Key? key,
    this.width = double.infinity,
    this.height = 50,
    this.radius = 10,
    this.backColor = Colors.blue,
    this.textColor = Colors.white,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: Styles.textStyle20.copyWith(color: textColor, fontSize: 20),
        ),
      ),
    );
  }
}

class ReusableTextFormField extends StatelessWidget {
  final String label;
  final double borderRadius;
  final Color activeColor;
  final void Function() onTap;
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
    this.activeColor = Colors.blue,
    required this.onTap,
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
        onTap: onTap,
        validator: validator,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          suffixIcon: suffix,
          prefixIcon: prefix,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: Colors.grey),
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
