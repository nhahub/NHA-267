import 'package:flutter/material.dart';
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

    // 1. بدء حركة تغيير اللون وحجم اللوجو
    Future.delayed(const Duration(milliseconds: 500), () {
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

                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Arabic Text
                  Text(
                    'دليلك للإيجار',
                    style: TextStyle(
                      color: _isAnimated ? Colors.white : kPrimaryColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      height: 1.2,

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