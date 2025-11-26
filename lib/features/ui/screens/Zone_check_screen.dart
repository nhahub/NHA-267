import 'package:depi_graduation_project/features/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
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
