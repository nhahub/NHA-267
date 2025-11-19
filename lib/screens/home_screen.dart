import 'package:flutter/material.dart';
import '../utils/constants.dart'; // <-- Import constants

class HomeScreenPlaceholder extends StatelessWidget {
  const HomeScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'الرئيسية',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor, // Use kPrimaryColor
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'محتوى التطبيق الرئيسي هنا',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}