import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../pages/home_screen/home_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'laws_screen.dart';
import 'unit_request_screen.dart';
import 'annual_increase_screen.dart';
import 'profile_screen.dart';

class ZoneCheckScreen extends StatelessWidget {
  const ZoneCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('معرفة فئة منطقتك')),
      body: const Center(child: Text('هذه شاشة فحص المنطقة')),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          if (index == 2) {} // Settings
        },
      ),
    );
  }
}
