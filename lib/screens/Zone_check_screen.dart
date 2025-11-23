import 'package:depi_graduation_project/screens/unit_request_screen.dart';
import 'package:flutter/material.dart';
import '../../features/ui/widgets/custom_bottom_nav_bar.dart';
import 'annual_increase_screen.dart';
import 'laws_screen.dart';
import 'profile_screen.dart';
import '../../../core/utils/app_colors.dart';

class ZoneCheckScreen extends StatelessWidget {
  const ZoneCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final floatingActionButton = FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
      },
      backgroundColor: AppColors.primaryColor,
      elevation: 4.0,
      shape: const CircleBorder(),
      child: const Icon(Icons.person, color: AppColors.whiteColor, size: 30),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('معرفة فئة منطقتك')),
      body: const Center(
        child: Text('هذه شاشة فحص المنطقة'),
      ),
      // 💡 يتم استخدام Index 0 (Home) كقيمة افتراضية لصفحات الخدمات التي لا تتبع الـ NavBar
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LawsScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ZoneCheckScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UnitRequestScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AnnualIncreaseScreen()));
          }
        },
      ),
    );
  }
}