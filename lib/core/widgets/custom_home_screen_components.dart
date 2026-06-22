import 'package:flutter/material.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';

class CustomHomeScreenComponents extends StatelessWidget {
  final String? title;
  final IconData? fisrt, second;
  const CustomHomeScreenComponents({
    super.key,
    this.title,
    this.fisrt,
    this.second,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Icon(fisrt, color: AppColors.greyColorsShade300),
          SizedBox(width: 10),
          Text(
            title!,
            style: TextStyle(color: AppColors.whiteColor, fontSize: 20),
          ),
          Spacer(),
          Icon(second, color: AppColors.greyColorsShade600),
        ],
      ),
    );
  }
}
