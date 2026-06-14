import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sync_rescue/core/theme/app_colors.dart';
import 'package:sync_rescue/features/auth/view_models/auth_view_model.dart';
import 'package:sync_rescue/features/auth/views/welcome_screen.dart';
import 'package:sync_rescue/features/sos_rescue/views/home_page.dart';
import 'package:sync_rescue/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sync Rescue',
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: AppColors.blackColor,
              body: Center(
                child: CircularProgressIndicator(color: AppColors.whiteColor),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text(
                  "System Offline. Please restart the app.",
                  style: TextStyle(color: AppColors.redColor),
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            return const HomePage();
          }

          return WelcomeScreen();
        },
      ),
    );
  }
}
