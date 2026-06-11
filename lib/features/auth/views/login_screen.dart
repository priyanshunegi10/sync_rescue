import 'package:flutter/material.dart';
import 'package:sync_rescue/core/widgets/custom_button.dart';
import 'package:sync_rescue/core/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  "assets/images/earthquake.png",
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "SYNC RESCUE",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: Icon(Icons.arrow_back_ios_new_rounded),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "let's sign you in.",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Welcome back\n You've been missed!",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            controller: emailController,
                            title: "Enter your email",
                            icon: Icon(Icons.email),
                          ),
                          SizedBox(height: 15),
                          CustomTextField(
                            controller: passwordController,
                            title: "Enter your password",
                            icon: Icon(Icons.lock),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Or")],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade600,
                                    width: 2,
                                  ),
                                ),
                                child: Image.asset("assets/icons/google.png"),
                              ),
                              SizedBox(width: 20),
                              Container(
                                padding: EdgeInsets.all(10),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade600,
                                    width: 2,
                                  ),
                                ),
                                child: Image.asset("assets/icons/facebook.png"),
                              ),
                            ],
                          ),
                          SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {},
                                child: Text("Signup"),
                              ),
                            ],
                          ),
                          CustomButton(
                            color: Colors.black,
                            title: "Login",
                            textColor: Colors.white,
                            onpress: () {},
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
