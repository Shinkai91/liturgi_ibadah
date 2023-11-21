import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:liturgi_ibadah/screens/splash_screen.dart';
import 'package:liturgi_ibadah/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 131, 57, 0),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}