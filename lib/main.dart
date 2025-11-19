import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // (1. عشان المقاسات)
import 'package:flutter_native_splash/flutter_native_splash.dart'; // (لإدارة شاشة الإطلاق الأصلية)

// (2. إمبورت للملفات الأساسية اللي اتفقنا عليها)
// (متخافش لو عملوا إيرور مؤقت، ده طبيعي)
import 'core/cache/SharedPreference.dart';
import 'DI/DI.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'screens/splash_screen.dart'; // (💡 شاشة البداية التي عملنا عليها)
import 'utils/constants.dart'; // (💡 الثوابت التي تحتوي على kPrimaryColor)

// (3. إمبورت للشاشات)
import 'features/ui/auth/login/logIn_screen.dart';


void main() async {
  // (4. دالة main "النضيفة")
  // 💡 يجب تهيئة WidgetsBinding أولا
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 💡 حماية شاشة الإطلاق الأصلية حتى يتم تحميل محرك Flutter
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // (تشغيل الـ Cache والـ DI قبل ما التطبيق يفتح)
  await SharedPreferenceUtils.init();
  // await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // (5. تغليف التطبيق بـ ScreenUtilInit)
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {

        // (6. الـ MaterialApp النضيف)
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'دليلك للإيجار',

          // 💡 تطبيق الثيم وإعداد الخطوط
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ).copyWith(
              secondary: kPrimaryColor,
            ),
            fontFamily: 'Inter', // الخط الذي اتفقنا عليه
            useMaterial3: true,
          ),

          // 💡 تحديد اتجاه النص (RTL) للغة العربية
          builder: (context, widget) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: widget!,
            );
          },

          // 💡 نقطة الانطلاق هي شاشة البداية (SplashScreen) لاستكمال الحركة
          home: const SplashScreen(),

          routes: {
            //AppRoutes.loginRoute: (context) => LoginScreen(),
            // (ضيف هنا باقي الشاشات لما تعملها)
          },
        );
      },
    );
  }
}