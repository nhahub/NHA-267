import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../pages/home_screen/home_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'profile_screen.dart';

class ZoneCheckScreen extends StatefulWidget {
  const ZoneCheckScreen({super.key});

  @override
  State<ZoneCheckScreen> createState() => _ZoneCheckScreenState();
}

class _ZoneCheckScreenState extends State<ZoneCheckScreen> {
  String? selectedGovernorate;

  final Map<String, String> governorateCategories = {
    // فئة متميزة
    "القاهرة": "متميزة",
    "الجيزة": "متميزة",
    "الإسكندرية": "متميزة",
    "بورسعيد": "متميزة",
    "جنوب سيناء": "متميزة",
    "البحر الأحمر": "متميزة",

    // فئة متوسطة
    "القليوبية": "متوسطة",
    "المنوفية": "متوسطة",
    "الغربية": "متوسطة",
    "الدقهلية": "متوسطة",
    "الإسماعيلية": "متوسطة",
    "السويس": "متوسطة",
    "البحيرة": "متوسطة",
    "كفر الشيخ": "متوسطة",
    "دمياط": "متوسطة",
    "بني سويف": "متوسطة",
    "الفيوم": "متوسطة",

    // فئة اقتصادية
    "الشرقية": "اقتصادية",
    "المنيا": "اقتصادية",
    "أسيوط": "اقتصادية",
    "سوهاج": "اقتصادية",
    "قنا": "اقتصادية",
    "الأقصر": "اقتصادية",
    "أسوان": "اقتصادية",
    "الوادي الجديد": "اقتصادية",
    "مطروح": "اقتصادية",
    "شمال سيناء": "اقتصادية",
  };

  final List<String> governorates = [
    "القاهرة",
    "الجيزة",
    "الإسكندرية",
    "بورسعيد",
    "السويس",
    "الإسماعيلية",
    "دمياط",
    "الدقهلية",
    "القليوبية",
    "الغربية",
    "المنوفية",
    "البحيرة",
    "كفر الشيخ",
    "الشرقية",
    "بني سويف",
    "الفيوم",
    "المنيا",
    "أسيوط",
    "سوهاج",
    "قنا",
    "الأقصر",
    "أسوان",
    "البحر الأحمر",
    "مطروح",
    "الوادي الجديد",
    "شمال سيناء",
    "جنوب سيناء",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'معرفة فئة منطقتك',
          style: AppStyles.semi20Primary.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.h),

            // Title
            Text(
              'اختر المحافظة',
              style: AppStyles.semi20Primary.copyWith(
                color: AppColors.primaryColor,
                fontSize: 22.sp,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Dropdown Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: DropdownButtonFormField<String>(
                  value: selectedGovernorate,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'اختر المحافظة',
                    hintStyle: AppStyles.regular16Text.copyWith(
                      color: AppColors.hintTextColor,
                    ),
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.primaryColor,
                    size: 32.sp,
                  ),
                  isExpanded: true,
                  style: AppStyles.regular16Text.copyWith(
                    color: AppColors.primaryDark,
                  ),
                  dropdownColor: AppColors.whiteColor,
                  items: governorates.map((String governorate) {
                    return DropdownMenuItem<String>(
                      value: governorate,
                      child: Text(
                        governorate,
                        style: AppStyles.regular16Text.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGovernorate = newValue;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Category Result Card
            if (selectedGovernorate != null)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                color: AppColors.whiteColor,
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      Text(
                        'الفئة',
                        style: AppStyles.semi16TextWhite.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          governorateCategories[selectedGovernorate] ??
                              'لم يتم تحديد الفئة الى الآن',
                          style: AppStyles.semi20Primary.copyWith(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 40.h),

            // Bottom Text
            Text(
              'دليلك للإيجار',
              style: AppStyles.semi16TextWhite.copyWith(
                color: AppColors.primaryColor,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: -1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
