import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sync_rescue/features/auth/view_models/auth_view_model.dart';
import 'package:sync_rescue/features/auth/views/welcome_screen.dart';

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
      title: 'synch rescue',
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: WelcomeScreen(),
    );
  }
}
