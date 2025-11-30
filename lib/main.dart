import 'package:depi_graduation_project/core/utils/my_bloc_observer.dart';
import 'package:depi_graduation_project/features/ui/auth/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart'; // تأكدنا من الامبورت ده
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';

import 'core/cache/SharedPreference.dart';
import 'DI/DI.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/app_theme.dart';
import 'core/utils/theme_manager.dart';

import 'features/ui/auth/Login/login_screen.dart';
import 'features/ui/auth/forgot/forgot_password_screen.dart';
import 'features/ui/auth/forgot/verify_otp_screen.dart';
import 'features/ui/pages/home_screen/home_screen.dart';
import 'features/ui/screens/splash_screen.dart';
import 'features/ui/screens/Settings_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  await SharedPreferenceUtils.init();

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

              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0xFF1F4C6B),
                scaffoldBackgroundColor: const Color(0xFF121212),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF121212),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

              // -------------------------

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
                AppRoutes.forgotPasswordRoute: (context) => const ForgotPasswordScreen(),
                '${AppRoutes.forgotPasswordRoute}/verify': (context) => const VerifyOtpScreen(),
                AppRoutes.homeRoute: (context) => const HomeScreen(),
                AppRoutes.settingsRoute: (context) => const SettingsScreen(),
              },
            );
          },
        );
      },
    );
  }
}