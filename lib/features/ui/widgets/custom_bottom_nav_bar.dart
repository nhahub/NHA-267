import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.whiteColor,
      child: SizedBox(
        height: 60.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.home_outlined, label: "الرئيسية", index: 0),
            _buildNavItem(icon: Icons.person_outline, label: "الملف الشخصي", index: 1),
            _buildNavItem(icon: Icons.settings_outlined, label: "الإعدادات", index: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24.w, color: isSelected ? AppColors.primaryColor : AppColors.hintTextColor),
          Text(label, style: TextStyle(fontSize: 10.sp, color: isSelected ? AppColors.primaryColor : AppColors.hintTextColor)),
        ],
      ),
    );
  }
}
