import 'package:depi_graduation_project/features/ui/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../utils/constants.dart';

import '../../../core/models/onboarding_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 💡 إضافة ScreenUtil

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isCurveVisible = false;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(kCurveAnimationDelay, () {
      if (mounted) {
        setState(() {
          _isCurveVisible = true;
        });
      }
    });

    _pageController.addListener(_onPageChange);
  }

  void _onPageChange() {
    if (_pageController.page != null) {
      int newIndex = _pageController.page!.round();
      if (_currentPageIndex != newIndex) {
        setState(() {
          _currentPageIndex = newIndex;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChange);
    _pageController.dispose();
    super.dispose();
  }

  // 💡 استخدام ScreenUtil للمقاسات الديناميكية
  Widget _buildOnboardingPage(OnboardingModel model) {
    return Column(
      // 💡 التوسيط لأعلى قليلاً لترك مساحة للمنحنى الأبيض
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // مسافة علوية لضبط المحاذاة بعد زر التخطي
        SizedBox(height: 50.h),

        // الصورة
        // نستخدم Expanded مع نسبة flex لتحديد أبعاد الصورة بشكل صحيح
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset(
              model.image,
              fit: BoxFit.contain,
            ),
          ),
        ),

        // العنوان
        Text(
          model.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),

        // الوصف
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            model.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF6C757D),
              fontSize: 15.sp,
            ),
          ),
        ),
        // 💡 هذه المسافة يجب أن تكون كافية لتجنب تداخل الكلام مع المنحنى الأبيض
        SizedBox(height: 140.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // ارتفاع الـ Curve ثابت
    const curveHeight = 150.0; // تقليل الارتفاع لتحرير مساحة أكبر

    const bottomPosition = 0.0;
    const hiddenPosition = -curveHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 💡 1. PageView: يتم وضع الشرائح هنا
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return _buildOnboardingPage(onboardingData[index]);
            },
          ),

          // 💡 زر التخطي (ثابت في أعلى الـ Stack)
          Positioned(
            top: 40.h,
            right: 15.w,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Text(
                'تخطي',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16.sp),
              ),
            ),
          ),


          // 💡 2. Curve والـ Indicator والأزرار (في الأسفل)
          AnimatedPositioned(
            duration: kAnimationDuration,
            curve: Curves.easeOut,
            bottom: _isCurveVisible ? bottomPosition : hiddenPosition,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, curveHeight),
              painter: BottomCurvePainter(),
              child: SizedBox(
                height: curveHeight,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 💡 مؤشر الصفحة (Page Indicator)
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: onboardingData.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: kPrimaryColor,
                          dotColor: Colors.grey.shade300,
                          dotHeight: 10.h,
                          dotWidth: 10.w,
                          spacing: 8.0,
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // 💡 زر "التالي" / "ابدأ"
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPageIndex == onboardingData.length - 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          _currentPageIndex == onboardingData.length - 1 ? 'ابدأ الآن' : 'التالي',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // 💡 مسافة سفلية
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomPainter لرسم المنحنى الأبيض (لا تغيير)
class BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path();

    // 💡 تعديل نقطة البداية والنهاية للمنحنى
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(
      size.width / 2, 0, size.width, size.height * 0.2,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}