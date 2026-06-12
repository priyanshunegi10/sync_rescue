import 'package:flutter/material.dart';
import 'package:sync_rescue/core/constants/app_string.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';
import 'package:sync_rescue/core/widgets/custom_button.dart';
import 'package:sync_rescue/features/auth/views/login_screen.dart';
import 'package:sync_rescue/features/auth/views/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(color: AppColors.blackColor),
                child: Image.asset(
                  "assets/images/fire.png",
                  fit: BoxFit.cover,

                  color: AppColors.blackColor.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),

            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: Text(
                            AppString.syncRescu,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          AppString.neighborhood,
                          style: TextStyle(
                            color: AppColors.greyColorsShade600,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomButton(
                            color: AppColors.blackColor,
                            title: AppString.login,
                            textColor: AppColors.whiteColor,
                            onpress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          CustomButton(
                            onpress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            color: AppColors.whiteColor,
                            title: AppString.signup,
                            textColor: AppColors.blackColor,
                          ),
                          SizedBox(height: 40),
                          Text(AppString.continuing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(AppString.privacyPolicy),
                              ),
                              Text(AppString.and),
                              TextButton(
                                onPressed: () {},
                                child: Text(AppString.terms),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
