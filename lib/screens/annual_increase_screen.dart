import 'package:depi_graduation_project/screens/unit_request_screen.dart';
import 'package:flutter/material.dart';
import '../../features/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:depi_graduation_project/screens/profile_screen.dart';
import '../../../core/utils/app_colors.dart';
import 'Zone_check_screen.dart';
import 'laws_screen.dart';

class AnnualIncreaseScreen extends StatelessWidget {
  const AnnualIncreaseScreen({super.key});

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
      appBar: AppBar(title: const Text('حساب الزيادة السنوية')),
      body: const Center(
        child: Text('هذه شاشة حاسبة الزيادة'),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
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