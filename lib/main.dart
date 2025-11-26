import 'package:depi_graduation_project/core/utils/my_bloc_observer.dart';
import 'package:depi_graduation_project/features/ui/auth/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/cache/SharedPreference.dart';
import 'DI/DI.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/theme_manager.dart';

// (إمبورت شاشة تسجيل الدخول)
import 'features/ui/auth/Login/login_screen.dart';
import 'features/ui/pages/home_screen/home_screen.dart' as full_home;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await SharedPreferenceUtils.init();
  await ThemeManager.init();


  configureDependencies();

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

        return ValueListenableBuilder<bool>(
          valueListenable: ThemeManager.isDark,
          builder: (context, isDark, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'دليلك للإيجار',

              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

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

              home: const full_home.HomeScreen(),

              routes: {
                AppRoutes.loginRoute: (context) => const LoginScreen(),
                AppRoutes.registerRoute: (context) => const RegisterScreen(),
                AppRoutes.homeRoute: (context) => const full_home.HomeScreen(),
              },
            );
          },
        );
      },
    );
  }
}