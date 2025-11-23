import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../screens/laws_screen.dart';
import '../../../screens//zone_check_screen.dart';
import '../../../screens/unit_request_screen.dart';
import '../../../screens/annual_increase_screen.dart';


// 💡 هذا الـ Widget مسؤول عن بناء شريط التنقل السفلي فقط
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
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: AppColors.whiteColor,
      child: SizedBox(
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            // ---- Left Side (index 0 & 1) ----
            _buildNavItem(
              icon: Icons.menu_book_outlined,
              label: "القوانين",
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.location_on_outlined,
              label: "المنطقه",
              index: 1,
            ),

            SizedBox(width: 48.w), // مكان الـ FAB

            // ---- Right Side (index 2 & 3) ----
            _buildNavItem(
              icon: Icons.key_outlined,
              label: "وحدة سكنية",
              index: 2,
            ),
            _buildNavItem(
              icon: Icons.trending_up_outlined,
              label: "الزيادة السنوية",
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.w,
              color: isSelected ? AppColors.primaryColor : AppColors.hintTextColor,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 9.sp,
                color: isSelected ? AppColors.primaryColor : AppColors.hintTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
