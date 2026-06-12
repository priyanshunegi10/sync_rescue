import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sync_rescue/core/constants/app_string.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';
import 'package:sync_rescue/core/utils/app_validators.dart';
import 'package:sync_rescue/core/widgets/custom_button.dart';
import 'package:sync_rescue/core/widgets/custom_extra_login_app_container.dart';
import 'package:sync_rescue/core/widgets/custom_text_field.dart';
import 'package:sync_rescue/features/auth/view_models/auth_view_model.dart';
import 'package:sync_rescue/features/auth/views/signup_screen.dart';
import 'package:sync_rescue/features/sos_rescue/views/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: AppColors.blackColor),
                  child: Image.asset(
                    "assets/images/earthquake.png",
                    fit: BoxFit.cover,

                    color: AppColors.blackColor.withOpacity(0.4),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),

              SafeArea(
                bottom: false,
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const Spacer(),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  AppString.syncRescu,
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 25,
                            ),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        AppColors.greyColorsShade300,
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  AppString.loginAccountTitle,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  AppString.loginAccountSubTitle,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: AppColors.greyColorsShade600,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        title: AppString.enterEmail,
                                        controller: emailController,
                                        icon: Icon(Icons.email),
                                        validator: AppValidators.validateEmail,
                                        isPassword: false,
                                        keybordtype: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(height: 20),
                                      CustomTextField(
                                        title: AppString.enterPassword,
                                        controller: passwordController,
                                        icon: Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _isPasswordHidden =
                                                  !_isPasswordHidden;
                                            });
                                          },
                                          icon: Icon(
                                            _isPasswordHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                        validator:
                                            AppValidators.validatePassword,
                                        isPassword: _isPasswordHidden,
                                        keybordtype: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text(AppString.or)],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomExtraLoginAppContainer(
                                      imagePath: "assets/icons/google.png",
                                      height: 50.0,
                                      width: 50.0,
                                    ),
                                    SizedBox(width: 20),
                                    CustomExtraLoginAppContainer(
                                      imagePath: "assets/icons/facebook.png",
                                      height: 50.0,
                                      width: 50.0,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 70),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(AppString.dontHaveAccount),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(AppString.signup),
                                    ),
                                  ],
                                ),
                                context.watch<AuthViewModel>().isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : CustomButton(
                                        color: AppColors.blackColor,
                                        title: AppString.login,
                                        textColor: AppColors.whiteColor,
                                        onpress: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            bool success = await context
                                                .read<AuthViewModel>()
                                                .login(
                                                  emailController.text.trim(),
                                                  passwordController.text
                                                      .trim(),
                                                );
                                            if (context.mounted) {
                                              if (success) {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage(),
                                                  ),
                                                  (route) => false,
                                                );
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      context
                                                          .read<AuthViewModel>()
                                                          .errorMessage,
                                                    ),
                                                    backgroundColor:
                                                        AppColors.redColor,
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
