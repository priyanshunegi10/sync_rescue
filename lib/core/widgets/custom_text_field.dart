import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Icon icon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: title,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
