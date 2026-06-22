import 'package:flutter/material.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';

class RescuerPageScreen extends StatefulWidget {
  const RescuerPageScreen({super.key});

  @override
  State<RescuerPageScreen> createState() => _RescuerPageScreenState();
}

class _RescuerPageScreenState extends State<RescuerPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: AppColors.whiteColor),
                ),
                Text(
                  "Rescuer Mode",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
