import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final VoidCallback onpress;
  const CustomButton({
    super.key,
    required this.color,
    required this.title,
    required this.textColor,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0.8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
