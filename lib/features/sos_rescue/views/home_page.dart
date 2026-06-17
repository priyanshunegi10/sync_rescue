import 'package:flutter/material.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: const DecoratedBox(
                decoration: BoxDecoration(color: AppColors.backgroundColor),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 30,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.lightWhite),
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightblue,
                                    AppColors.darkblue,
                                  ],
                                  begin: AlignmentGeometry.topCenter,
                                  end: AlignmentGeometry.bottomCenter,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "Emergency",
                                    style: TextStyle(
                                      color: AppColors.lightWhite,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,

                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "SOS",
                                          style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 70,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Rescuer Mode",
                                        style: TextStyle(
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 25,
                      ),

                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.lightblue, AppColors.darkblue],
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                        ),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(22),
                          right: Radius.circular(22),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),

                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: AppColors.greyColorsShade300,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "My device",
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.greyColorsShade600,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),

                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: AppColors.greyColorsShade300,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "My device",
                                    style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.greyColorsShade600,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
