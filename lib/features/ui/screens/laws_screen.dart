import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../pages/home_screen/home_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'zone_check_screen.dart';
import 'unit_request_screen.dart';
import 'annual_increase_screen.dart';
import 'profile_screen.dart';

class LawsScreen extends StatelessWidget {
  const LawsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('القوانين')),
      body: const Center(child: Text('هذه شاشة القوانين')),

      // نفس BottomNavigationBar الموجود في HomeScreen
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1, // مفيش زرار منور
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          } else if (index == 2) {
            // Settings (لو موجود)
          }
        },
      ),
    );
  }
}
