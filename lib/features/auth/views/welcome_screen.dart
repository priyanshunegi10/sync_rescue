import 'package:flutter/material.dart';
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
                decoration: const BoxDecoration(color: Colors.black),
                child: Image.asset(
                  "assets/images/fire.png",
                  fit: BoxFit.cover,

                  color: Colors.black.withOpacity(0.4),
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: Text(
                            "SYNC RESCUE",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "NEIGHBORHOOD AID NETWORK",
                          style: TextStyle(
                            color: Colors.white70,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomButton(
                            color: Colors.black,
                            title: "Log in",
                            textColor: Colors.white,
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
                            color: Colors.white,
                            title: "sign up",
                            textColor: Colors.black,
                          ),
                          SizedBox(height: 40),
                          Text("By continuing, you agree to Sync rescue's"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text("Privacy Policy"),
                              ),
                              Text("and"),
                              TextButton(
                                onPressed: () {},
                                child: Text("Terms of Use."),
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
