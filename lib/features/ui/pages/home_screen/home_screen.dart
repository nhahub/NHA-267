import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen'; // اسم الروت

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "مبروك! تم تسجيل الدخول بنجاح 🎉",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}