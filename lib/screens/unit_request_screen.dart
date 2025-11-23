import 'package:flutter/material.dart';
import '../../features/ui/widgets/custom_bottom_nav_bar.dart';
import '../../../screens/profile_screen.dart';
import '../../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import 'Zone_check_screen.dart';
import 'annual_increase_screen.dart';
import 'laws_screen.dart';

class UnitRequestScreen extends StatelessWidget {
  const UnitRequestScreen({super.key});

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
      appBar: AppBar(title: Text('طلب وحدة سكنية', style: AppStyles.semi20Primary.copyWith(color: AppColors.whiteColor))),
      body: const Center(
        child: Text('هذه شاشة طلب وحدة سكنية'),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
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