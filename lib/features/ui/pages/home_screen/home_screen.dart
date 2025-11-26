import 'package:depi_graduation_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen'; // اسم الروت

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea( // ضفنا SafeArea عشان الهيدر مايدخلش في نوتش الموبايل
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildCustomHeader(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      children: [
                        // 1. القوانين
                        _buildServiceItem(
                          title: 'القوانين',
                          imagePath: 'assets/images/laws.png',
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const LawsScreen()));
                          },
                        ),
                        // 2. معرفة فئة منطقتك
                        _buildServiceItem(
                          title: 'معرفه فئه منطقتك',
                          imagePath: 'assets/images/zone.png',
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const ZoneCheckScreen()));
                          },
                        ),
                        // 3. طلب وحدة سكنية
                        _buildServiceItem(
                          title: 'طلب وحدة سكنية',
                          imagePath: 'assets/images/building.png',
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const UnitRequestScreen()));
                          },
                        ),
                        // 4. حساب الزيادة السنوية
                        _buildServiceItem(
                          title: 'حساب الزيادة السنوية',
                          imagePath: 'assets/images/increase.png',
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const AnnualIncreaseScreen()));
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
      // لو عندك CustomBottomNavBar الغي الكومنت من هنا

      floatingActionButton: FloatingActionButton(
        onPressed: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
        backgroundColor: AppColors.primaryColor,
        elevation: 4.0,
        shape: const CircleBorder(),
        child: const Icon(Icons.person, color: AppColors.whiteColor, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // التنقل بين الصفحات
        },
      ),

    );
  }
}