import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../pages/home_screen/home_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'profile_screen.dart';

class UnitRequestScreen extends StatelessWidget {
  const UnitRequestScreen({super.key});

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(
        'https://digital.gov.eg/categories/terms/%D8%AA%D9%82%D8%AF%D9%8A%D9%85-%D8%B7%D9%84%D8%A8-%D8%AD%D8%AC%D8%B2-%D9%88%D8%AD%D8%AF%D8%A9-%D8%B3%D9%83%D9%86%D9%8A%D8%A9');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          'طلب وحدة سكنية',
          style: AppStyles.semi20Primary.copyWith(color: AppColors.whiteColor),
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
            SizedBox(height: 40.h),

            // Icon
            Icon(
              Icons.home_work_rounded,
              size: 80.sp,
              color: AppColors.primaryColor,
            ),

            SizedBox(height: 32.h),

            // Title
            Text(
              'تقديم طلب حجز وحدة سكنية',
              style: AppStyles.semi20Primary.copyWith(
                color: AppColors.primaryColor,
                fontSize: 24.sp,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16.h),

            // Description
            Text(
              'يمكنك تقديم طلب للحصول على وحدة سكنية من خلال بوابة مصر الرقمية',
              style: AppStyles.regular16Text.copyWith(
                color: AppColors.primaryDark,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 48.h),

            // Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'معلومات هامة',
                          style: AppStyles.semi16TextWhite.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _buildInfoItem(
                        'يتم تقديم الطلب عبر الموقع الرسمي للحكومة المصرية'),
                    _buildInfoItem('سيتم توجيهك إلى صفحة التقديم الرسمية'),
                    _buildInfoItem('تأكد من توفر جميع المستندات المطلوبة'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 40.h),

            // Main Button
            ElevatedButton(
              onPressed: _launchURL,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تقديم الطلب الآن',
                    style: AppStyles.semi16TextWhite.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Secondary Info
            Text(
              'خدمة مقدمة من بوابة مصر الرقمية',
              style: AppStyles.regular14Text.copyWith(
                color: AppColors.primaryDark.withOpacity(0.6),
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

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6.h, left: 8.w),
            width: 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppStyles.regular14Text.copyWith(
                color: AppColors.primaryDark,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
