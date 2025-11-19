import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // للتحكم في حركة ظهور الـ Curve وزر "ابدأ"
  bool _isCurveVisible = false;

  @override
  void initState() {
    super.initState();
    // تأخير صغير لبدء الحركة بعد الانتقال من الشاشة الزرقاء
    Future.delayed(kCurveAnimationDelay, () {
      if (mounted) {
        setState(() {
          _isCurveVisible = true; // تبدأ حركة الصعود
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ارتفاع الـ Curve ثابت
    const curveHeight = 250.0;

    // الموضع النهائي للـ Curve (من أسفل الشاشة)
    final bottomPosition = 0.0;
    // الموضع الابتدائي للـ Curve (أخفاه تماماً أسفل الشاشة)
    final hiddenPosition = -curveHeight;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          // Content: Logo and Text (Centered - ثابت)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'دليلك للإيجار',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 💡 حركة ظهور الـ Curve وزر "ابدأ" باستخدام AnimatedPositioned
          AnimatedPositioned(
            duration: kAnimationDuration, // 1 ثانية
            curve: Curves.easeOut,
            // تحديد الموضع الرأسي للـ Curve.
            bottom: _isCurveVisible ? bottomPosition : hiddenPosition,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, curveHeight),
              painter: BottomCurvePainter(),
              child: SizedBox(
                height: curveHeight,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // التنقل إلى شاشة Home Screen بعد الضغط على "ابدأ"
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreenPlaceholder(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'ابدأ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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

    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(
      size.width / 2, 0, size.width, size.height * 0.3,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}