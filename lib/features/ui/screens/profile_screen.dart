import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: AppStyles.semi20Primary.copyWith(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        // 💡 حل مشكلة زر الرجوع: تحديد لون الأيقونة ليكون أبيضًا
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: const Center(
        child: Text(
          'هذه شاشة الملف الشخصي والحساب',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}