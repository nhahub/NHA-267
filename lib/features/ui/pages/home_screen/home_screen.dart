import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../screens/Zone_check_screen.dart';
import '../../screens/annual_increase_screen.dart';
import '../../screens/laws_screen.dart';
import '../../screens/unit_request_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/settings_screen.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import 'package:depi_graduation_project/core/utils/app_routes.dart';
import '../../../../core/cache/SharedPreference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'مستخدم';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() {
    setState(() {
      String? savedName = SharedPreferenceUtils.getData(key: 'name') as String?;
      if (savedName != null) {
        userName = savedName.split(' ').first;
      }
    });
  }

  void _onTap(int index) {
    if (index == 0) return;
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      ).then((_) {
        _loadUserName();
      });
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SettingsScreen()),
      );
    }
  }

  // ✅ 1. عدلنا الدالة دي عشان تاخد لون الخلفية كـ باراميتر
  Widget _buildCustomHeader(Color backgroundColor) {
    return Container(
      color: backgroundColor, // هنا اللون المتغير
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اهلا بيك ',
                  style: AppStyles.regular16Text.copyWith(
                    color: AppColors.primaryColor,
                  )),
              Text(userName,
                  style: AppStyles.medium20White.copyWith(
                    color: AppColors.primaryColor,
                  )),
              SizedBox(height: 10.h),
            ],
          ),
          SizedBox(
            height: 80.h,
            width: 80.w,
            child: Image.asset(
              'assets/images/logo.png',
              color: AppColors.primaryColor,
              colorBlendMode: BlendMode.srcIn,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
    required Color cardColor,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.offwhiteColor,
                ),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: AppStyles.medium18Header
                      .copyWith(color: textColor),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 20, color: textColor), // تطبيق لون السهم
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color backgroundColor = isDark ? const Color(0xFF121212) : AppColors.whiteColor;
    Color cardColor = isDark ? const Color(0xFF1E1E1E) : AppColors.whiteColor;
    Color textColor = isDark ? Colors.white : AppColors.fontColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildCustomHeader(backgroundColor),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      children: [
                        _buildServiceItem(
                          title: 'القوانين',
                          imagePath: 'assets/images/laws.png',
                          cardColor: cardColor,
                          textColor: textColor,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const LawsScreen()));
                          },
                        ),
                        _buildServiceItem(
                          title: 'معرفة فئة منطقتك',
                          imagePath: 'assets/images/zone.png',
                          cardColor: cardColor,
                          textColor: textColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ZoneCheckScreen()));
                          },
                        ),
                        _buildServiceItem(
                          title: 'طلب وحدة سكنية',
                          imagePath: 'assets/images/building.png',
                          cardColor: cardColor,
                          textColor: textColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const UnitRequestScreen()));
                          },
                        ),
                        _buildServiceItem(
                          title: 'حساب الإيجار الجديد',
                          imagePath: 'assets/images/increase.png',
                          cardColor: cardColor,
                          textColor: textColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AnnualIncreaseScreen()));
                          },
                        ),
                        SizedBox(height: 70.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: _onTap,
      ),
    );
  }
}