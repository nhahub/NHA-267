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
    // 1️⃣ تحديد الألوان حسب الوضع (فاتح / غامق)
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    // لو دارك مود، الخلفية بتبقى رمادي غامق، ولو لايت بتبقى أبيض
    Color bgColor = isDark ? const Color(0xFF1E1E1E) : AppColors.whiteColor;

    // لون الأيقونات غير النشطة (رمادي فاتح في الدارك، ورمادي غامق في اللايت)
    Color inactiveColor = isDark ? Colors.grey[400]! : AppColors.hintTextColor;

    return BottomAppBar(
      color: bgColor, // ✅ لون الخلفية متغير
      elevation: 10,  // ظل خفيف عشان يفصلها عن المحتوى
      child: SizedBox(
        height: 60.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
                icon: Icons.home_outlined,
                label: "الرئيسية",
                index: 0,
                inactiveColor: inactiveColor
            ),
            _buildNavItem(
                icon: Icons.person_outline,
                label: "الملف الشخصي",
                index: 1,
                inactiveColor: inactiveColor
            ),
            _buildNavItem(
                icon: Icons.settings_outlined,
                label: "الإعدادات",
                index: 2,
                inactiveColor: inactiveColor
            ),
          ],
        ),
      ),
    );
  }

  // عدلنا الدالة عشان تستقبل اللون غير النشط
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required Color inactiveColor
  }) {
    bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              icon,
              size: 24.w,
              // اللون النشط بيفضل Primary، وغير النشط بيتغير حسب الثيم
              color: isSelected ? AppColors.primaryColor : inactiveColor
          ),
          Text(
              label,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: isSelected ? AppColors.primaryColor : inactiveColor
              )
          ),
        ],
      ),
    );
  }
}