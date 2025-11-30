import 'package:flutter/material.dart';
import '../../../core/cache/SharedPreference.dart'; // تأكد من المسار
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = "جاري التحميل...";
  String registrationNumber = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    var debugName = SharedPreferenceUtils.getData(key: 'name');
    print("Profile Screen Loaded Name: $debugName");
    setState(() {
      fullName = SharedPreferenceUtils.getData(key: 'name') as String? ?? "مستخدم";
      email = SharedPreferenceUtils.getData(key: 'email') as String? ?? "لا يوجد بريد";
      registrationNumber = SharedPreferenceUtils.getData(key: 'phone') as String? ?? "لا يوجد رقم";
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الملف الشخصي',
          style: AppStyles.semi20Primary.copyWith(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            Text(
              'الاسم الكامل',
              style: AppStyles.semi16TextWhite.copyWith(color: Colors.black), // تعديل اللون ليظهر
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

            Text(
              'الرقم المسجل',
              style: AppStyles.semi16TextWhite.copyWith(color: Colors.black),
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

            Text(
              'الايميل',
              style: AppStyles.semi16TextWhite.copyWith(color: Colors.black),
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