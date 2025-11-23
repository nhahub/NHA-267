import 'package:depi_graduation_project/screens/unit_request_screen.dart';
import 'package:flutter/material.dart';
import '../../features/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:depi_graduation_project/screens/profile_screen.dart';
import '../../../core/utils/app_colors.dart';
import 'Zone_check_screen.dart';
import 'annual_increase_screen.dart';

class LawsScreen extends StatelessWidget {
  const LawsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 💡 زر الـ FAB المخصص (نكرر الكود هنا أو نجعله دالة مساعدة)
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
      appBar: AppBar(title: const Text('القوانين')),
      body: const Center(
        child: Text('هذه شاشة القوانين'),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
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