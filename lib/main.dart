import 'package:flutter/material.dart';
import 'Home_page.dart';
import 'Signup_page.dart';

// --- Color Constants (Shared) ---
const Color kDarkBackground = Color(0xFF1E1B36); // Main background (HomeScreen)
const Color kHeaderBackground = Color(0xFF2F295B); // Top background / progress card
const Color kPurple = Color(0xFFC259D4); // Excelerate Purple/Pink
const Color kOrange = Color(0xFFFF8C4B); // Get Started Button
const Color kLightBlueCard = Color(0xFFD3E1FF); // Horizontal Card background
const Color kPrimaryText = Colors.white;
const Color kSecondaryText = Color(0xFF9CA3AF);
const Color kProgressRemaining = Color(0xFF4B477A);
const Color kBottomNavActive = Color(0xFF7C3AED);

// --- Auth Screen Constants ---
const Color kSignUpBackground = Color(0xFF1E1B2E); // Darker background for auth screen
const Color kTextFieldFill = Color(0xFF2C2746); // Input field background
const Color kPrimaryButton = Color(0xFF4C5AFE); // Sign Up/Login Button

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kDarkBackground,
        useMaterial3: true,
      ),
      // App starts on the SignUpScreen
      home: const SignUpScreen(),
    );
  }
}
