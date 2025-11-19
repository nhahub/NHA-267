  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart'; // (1. عشان المقاسات)

  // (2. إمبورت للملفات الأساسية اللي اتفقنا عليها)
  // (متخافش لو عملوا إيرور مؤقت، ده طبيعي)
  import 'core/cache/SharedPreference.dart';
  import 'DI/DI.dart';
  import 'core/utils/app_routes.dart';
  import 'core/utils/app_theme.dart';

  // (3. إمبورت للشاشات - هيعمل إيرور مؤقت لحد ما ننشئها)
  import 'features/ui/auth/Login/LogIn_screen.dart';


  void main() async {
    // (4. دالة main "النضيفة" اللي اتفقنا عليها)
    WidgetsFlutterBinding.ensureInitialized();

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
            title: 'تطبيق الإيجار',
            //initialRoute: AppRoutes.loginRoute,

            routes: {
              //AppRoutes.loginRoute: (context) => LoginScreen(),
              // (ضيف هنا باقي الشاشات لما تعملها)
            },
          );
        },
      );
    }
  }