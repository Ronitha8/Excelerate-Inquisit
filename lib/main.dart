import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:excelerate_inquisit/screens/login_screen.dart';
import 'package:excelerate_inquisit/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBeieWqVV-_H9iu_VkTaGMrq3dtdTDLma4",
      authDomain: "excelerate-inquisit.firebaseapp.com",
      projectId: "excelerate-inquisit",
      storageBucket: "excelerate-inquisit.firebasestorage.app",
      messagingSenderId: "50794013537",
      appId: "1:50794013537:web:871b8899b39ff48f2c5b20",
      measurementId: "G-BNZTVYY6JY",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Inquisit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: kDarkBackground,
      ),
      home: const LoginScreen(),
    );
  }
}