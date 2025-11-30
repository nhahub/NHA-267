import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../utils/constants.dart';
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

    FlutterNativeSplash.remove();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _isAnimated = true;
        });
      }
    });

    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
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