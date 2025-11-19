import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/ui/auth/login/login_screen.dart';
import 'core/cache/SharedPreference.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/constants.dart';
import 'screens/splash_screen.dart'; // شاشتك للبداية

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // حماية شاشة الإطلاق الأصلية حتى يكتمل تحميل Flutter
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SharedPreferenceUtils.init();
  // await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'تطبيق الإيجار القديم',

          // 💡 تطبيق الثيم والخطوط
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ).copyWith(
              secondary: kPrimaryColor,
            ),
            fontFamily: 'Inter',
            useMaterial3: true,
          ),

          // 💡 اللغة الأساسية عربية
          locale: const Locale('ar'),

          // 💡 المندوبين المسؤولين عن الترجمة والاتجاه
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // 💡 اللغات المدعومة
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],

          // 💡 اتجاه النصوص داخل التطبيق (شمال)
          builder: (context, widget) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: widget!,
            );
          },

          // 💡 نقطة البداية هي SplashScreen
          home: const SplashScreen(),

          // 💡 إعداد الـ Routes للتنقل
          routes: {
            AppRoutes.loginRoute: (context) => const LoginScreen(),
          },
        );
      },
    );
  }
}
