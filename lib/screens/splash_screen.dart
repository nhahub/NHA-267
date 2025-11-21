import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'; // 💡 استيراد ضروري
import '../utils/constants.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();

    // 💡 إخفاء شاشة الإطلاق الأصلية فوراً بمجرد ظهور شاشة Flutter
    FlutterNativeSplash.remove();

    // 1. بدء حركة تغيير اللون وحجم اللوجو
    // (تم تقليل المدة لـ 100ms للبدء فور إزالة الشاشة الأصلية)
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isAnimated = true;
        });
      }
    });

    // 2. التنقل: يتم بعد انتهاء مدة الحركة + وقت فاصل
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // ننتظر مدة الحركة (1000ms) + وقت فاصل (300ms) = 1300ms
    await Future.delayed(kAnimationDuration + const Duration(milliseconds: 300));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Uses kAnimationDuration
    return AnimatedContainer(
      duration: kAnimationDuration,
      curve: Curves.easeInOut,
      // الخلفية تتغير من الأبيض إلى الأزرق
      color: _isAnimated ? kPrimaryColor : Colors.white,

      // 💡 الحل النهائي: نغلف المحتوى بـ SafeArea
      child: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            duration: kAnimationDuration,
            opacity: _isAnimated ? 1.0 : 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  AnimatedContainer(
                    duration: kAnimationDuration,
                    curve: Curves.easeOutBack,
                    height: _isAnimated ? 140 : 80,
                    width: _isAnimated ? 140 : 80,

                    child: Image.asset(
                      'assets/images/splash.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}