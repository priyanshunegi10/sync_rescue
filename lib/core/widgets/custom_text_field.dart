import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Icon icon;
  final TextInputType keybordtype;
  final TextInputAction textInputAction;
  final bool isPassword;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
    required this.validator,
    this.keybordtype = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keybordtype,
      textInputAction: textInputAction,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        hintText: title,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
