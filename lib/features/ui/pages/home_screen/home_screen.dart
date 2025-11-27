import 'package:depi_graduation_project/features/ui/screens/Settings_Screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../screens/Zone_check_screen.dart';
import '../../screens/annual_increase_screen.dart';
import '../../screens/laws_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/unit_request_screen.dart';
import '../../widgets/custom_bottom_nav_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  Widget _buildServiceItem({required String title, required String image, required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [BoxShadow(color: AppColors.blackColor.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 4))],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 120.w,
                child: ClipRRect(borderRadius: BorderRadius.circular(15.r), child: Image.asset(image, fit: BoxFit.cover)),
              ),
              SizedBox(width: 16.w),
              Expanded(child: Text(title, style: AppStyles.medium20White.copyWith(color: AppColors.fontColor))),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            children: [
              Text("القائمة الرئيسية", style: AppStyles.medium20White.copyWith(color: AppColors.primaryColor)),
              SizedBox(height: 20.h),
              _buildServiceItem(title: "القوانين", image: "assets/images/laws.png", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LawsScreen()))),
              _buildServiceItem(title: "معرفة فئة منطقتك", image: "assets/images/zone.png", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ZoneCheckScreen()))),
              _buildServiceItem(title: "طلب وحدة سكنية", image: "assets/images/building.png", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UnitRequestScreen()))),
              _buildServiceItem(title: "حساب الزيادة السنوية", image: "assets/images/increase.png", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AnnualIncreaseScreen()))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          if (index == 2) {Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));} // Settings page
        },
      ),
    );
  }
}
