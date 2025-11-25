import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../domain/repositories/auth_repository_impl.dart';
import 'profile_screen.dart';
import '../features/ui/widgets/custom_bottom_nav_bar.dart';
// 💡 استيراد شاشات الخدمات
import 'laws_screen.dart';
import 'zone_check_screen.dart';
import 'unit_request_screen.dart';
import 'annual_increase_screen.dart';


class HomeScreenPlaceholder extends StatefulWidget {
  const HomeScreenPlaceholder({super.key});

  @override
  State<HomeScreenPlaceholder> createState() => _HomeScreenPlaceholderState();
}

class _HomeScreenPlaceholderState extends State<HomeScreenPlaceholder> {
  String _userName = 'مستخدم';
  final AuthRepositoryImpl _authRepository = AuthRepositoryImpl();

  final int _currentIndex = 0; // 💡 Index لصفحة Home في الـ NavBar

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    final name = await _authRepository.getUserName();
    if (mounted && name != null) {
      setState(() {
        _userName = name.split(' ').first;
      });
    }
  }

  Widget _buildServiceItem({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 120.w,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primaryDarkLight.withOpacity(0.1),
                      child: const Center(child: Icon(Icons.image, color: AppColors.primaryDark)),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    title,
                    style: AppStyles.medium20White.copyWith(color: AppColors.fontColor),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('صباح الخير', style: AppStyles.regular16Text.copyWith(color: AppColors.primaryDark)),
              Text(_userName, style: AppStyles.medium20White.copyWith(color: AppColors.primaryColor)),
              SizedBox(height: 10.h),

              GestureDetector(
                onTap: () {
                  // فتح شاشة الإعدادات
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryDarkLight),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text('الإعدادات', style: AppStyles.medium14PrimaryDark),
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    // 💡 زر الـ FAB المخصص (الملف الشخصي)
    final floatingActionButton = FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
      },
      backgroundColor: AppColors.primaryColor,
      elevation: 4.0,
      shape: const CircleBorder(),
      child: const Icon(Icons.person, color: AppColors.whiteColor, size: 30),
    );

    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildCustomHeader(),

                // 💡 محتوى الصفحة (الخدمات الأربعة)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    children: [
                      // 1. القوانين
                      _buildServiceItem(
                        title: 'القوانين',
                        imagePath: 'assets/images/laws.png',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LawsScreen()));
                        },
                      ),
                      // 2. معرفة فئة منطقتك
                      _buildServiceItem(
                        title: 'معرفه فئه منطقتك',
                        imagePath: 'assets/images/zone.png',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ZoneCheckScreen()));
                        },
                      ),
                      // 3. طلب وحدة سكنية
                      _buildServiceItem(
                        title: 'طلب وحدة سكنية',
                        imagePath: 'assets/images/building.png',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UnitRequestScreen()));
                        },
                      ),
                      // 4. حساب الزيادة السنوية
                      _buildServiceItem(
                        title: 'حساب الزيادة السنوية',
                        imagePath: 'assets/images/increase.png',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnualIncreaseScreen()));
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

      // 💡 استخدام الـ FAB والـ BottomNavBar
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LawsScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ZoneCheckScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const UnitRequestScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AnnualIncreaseScreen()));
          }
        },
      ),

    );
  }
}