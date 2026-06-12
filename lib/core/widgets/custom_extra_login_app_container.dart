import 'package:flutter/material.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';

class CustomExtraLoginAppContainer extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  const CustomExtraLoginAppContainer({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.greyColorsShade600, width: 2),
      ),
      child: Image.asset(imagePath),
    );
  }
}
