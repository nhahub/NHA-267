import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'laws_screen.dart';
import 'zone_check_screen.dart';
import 'unit_request_screen.dart';
import 'profile_screen.dart';

class AnnualIncreaseScreen extends StatelessWidget {
  const AnnualIncreaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حساب الزيادة السنوية')),
      body: const Center(child: Text('هذه شاشة حاسبة الزيادة')),

      // NavBar بثلاثة أزرار فقط
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          if (index == 2) {}
        },
      ),
    );
  }
}
