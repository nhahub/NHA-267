import 'package:depi_graduation_project/core/utils/app_colors.dart';
import 'package:depi_graduation_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_graduation_project/core/utils/app_styles.dart';
import 'package:depi_graduation_project/screens/Search_screen.dart';
import 'package:depi_graduation_project/screens/Categories_screen.dart';
import 'package:depi_graduation_project/screens/Settings_Screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<int> _history = [];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const _HomeContent(),
      SearchScreen(onBack: () => _onBackPressed()),
      CategoriesScreen(onBack: () => _onBackPressed()),
      SettingsScreen(onBack: () => _onBackPressed()),
    ];
  }

  void _onTap(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _history.add(_currentIndex);
      _currentIndex = index;
    });
  }

  void _onBackPressed() {
    if (_history.isNotEmpty) {
      setState(() {
        _currentIndex = _history.removeLast();
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedIconTheme: IconThemeData(size: 22, color: Theme.of(context).colorScheme.secondary),
          unselectedIconTheme: IconThemeData(size: 20, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: const Icon(Icons.search), label: 'بحث'),
            BottomNavigationBarItem(icon: const Icon(Icons.grid_view), label: 'الفئات'),
            BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'الاعدادات'),
          ],
        ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  final String _userName = 'الحج محمد';

  Widget _buildCustomHeader() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('صباح الخير', style: AppStyles.regular16Text.copyWith(color: Theme.of(context).colorScheme.primary)),
              Text(_userName, style: AppStyles.medium20White.copyWith(color: Theme.of(context).colorScheme.primary)),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  // فتح شاشة الإعدادات
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text('الإعدادات', style: AppStyles.medium14PrimaryDark.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 80.h,
            width: 80.w,
            child: Image.asset(
              'assets/images/logo.png',
              color: Theme.of(context).colorScheme.primary,
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      color: Theme.of(context).iconTheme.color,
                    );
                  },
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).iconTheme.color,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        },
        backgroundColor: AppColors.primaryColor,
        elevation: 4.0,
        shape: const CircleBorder(),
        child: const Icon(Icons.person, color: AppColors.whiteColor, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}