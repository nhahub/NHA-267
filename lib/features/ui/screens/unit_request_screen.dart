import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../pages/home_screen/home_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'laws_screen.dart';
import 'zone_check_screen.dart';
import 'annual_increase_screen.dart';
import 'profile_screen.dart';

class UnitRequestScreen extends StatelessWidget {
  const UnitRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('طلب وحدة سكنية', style: AppStyles.semi20Primary.copyWith(color: AppColors.whiteColor))),
      body: const Center(child: Text('هذه شاشة طلب وحدة سكنية')),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1, // حسب ترتيب NavBar
        onTap: (index) {
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          if (index == 2) {} // Settings
        },
      ),
    );
  }
}
