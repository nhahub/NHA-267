import 'package:depi_graduation_project/features/ui/auth/register/registerScreenStates/register_screen.dart';
import 'package:depi_graduation_project/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/cache/SharedPreference.dart';
import 'DI/DI.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';

import 'screens/splash_screen.dart';
import 'utils/constants.dart';

import 'features/ui/auth/Login/login_screen.dart';


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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
          title: 'دليلك للإيجار',

          theme: AppTheme.lightTheme, // 💡 استخدام الـ Theme المعرّف

          locale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],

          builder: (context, widget) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: widget!,
            );
          },

          home: const SplashScreen(),

          routes: {
            AppRoutes.loginRoute: (context) => const LoginScreen(),
            AppRoutes.registerRoute: (context) => const RegisterScreen(),
            AppRoutes.homeRoute: (context) => const HomeScreenPlaceholder(),
            AppRoutes.profileRoute: (context) => const HomeScreenPlaceholder(),
          },
        );
      },
    );
  }
}