import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // 1. تأكد إن المكتبة دي معمولة في pubspec.yaml

import 'features/ui/auth/login/login_screen.dart';
import 'core/cache/SharedPreference.dart';
// import 'DI/DI.dart'; // لو لسه مش شغال، سيبه كومنت
import 'core/utils/app_routes.dart';
// import 'core/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          title: 'تطبيق الإيجار',

          // 2. هنا بنحدد اللغة اللي هيبدأ بيها (عربي)
          locale: const Locale('ar'),

          // 3. (الجزء الناقص عندك) المندوبين المسؤولين عن الترجمة والاتجاهات
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // 4. (الجزء الناقص عندك) اللغات المدعومة في التطبيق
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],

          initialRoute: AppRoutes.loginRoute,
          routes: {
            AppRoutes.loginRoute: (context) => LoginScreen(),
          },
        );
      },
    );
  }
}