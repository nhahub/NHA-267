import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  final String fullName = 'حمد محمد علي محمد';
  final String registrationNumber = '01204193836';
  final String email = 'moharned12323@gmail.com';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instant Book Header
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settingsRoute);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'الاعدادات',
                  textAlign: TextAlign.center,
                  style: AppStyles.semi20Primary.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Full Name Field
            Text(
              'الاسم الكامل',
              style: AppStyles.semi16TextWhite,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
              ),
              child: Text(
                fullName,
                style: AppStyles.regular14Text,
              ),
            ),
            const SizedBox(height: 16),
            // Registration Number Field
            Text(
              'الرقم المسجل',
              style: AppStyles.semi16TextWhite,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
              ),
              child: Text(
                registrationNumber,
                style: AppStyles.regular14Text,
              ),
            ),
            const SizedBox(height: 16),
            // Email Field
            Text(
              'الايميل',
              style: AppStyles.semi16TextWhite,
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
              ),
              child: Text(
                email,
                style: AppStyles.regular14Text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}