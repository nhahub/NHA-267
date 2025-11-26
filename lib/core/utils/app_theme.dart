import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    brightness: Brightness.light,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primaryDark,
    brightness: Brightness.dark,
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: _lightScheme,
    primaryColor: _lightScheme.primary,
    scaffoldBackgroundColor: _lightScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightScheme.surface,
      elevation: 0,
      iconTheme: IconThemeData(color: _lightScheme.onSurface),
      titleTextStyle: TextStyle(color: _lightScheme.onSurface, fontSize: 20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightScheme.surface,
      selectedItemColor: _lightScheme.secondary,
      unselectedItemColor: Colors.grey[600],
      showUnselectedLabels: true,
      showSelectedLabels: true,
      elevation: 8,
    ),
    dividerColor: Colors.grey[300],
    textTheme: const TextTheme(),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(_lightScheme.primary),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return _lightScheme.primary.withOpacity(0.4);
        return Colors.grey.withOpacity(0.3);
      }),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: _darkScheme,
    brightness: Brightness.dark,
    primaryColor: _darkScheme.primary,
    scaffoldBackgroundColor: _darkScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkScheme.surface,
      elevation: 0,
      iconTheme: IconThemeData(color: _darkScheme.onSurface),
      titleTextStyle: TextStyle(color: _darkScheme.onSurface, fontSize: 20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkScheme.surface,
      selectedItemColor: _darkScheme.secondary,
      unselectedItemColor: Colors.grey[400],
      showUnselectedLabels: true,
      showSelectedLabels: true,
      elevation: 8,
    ),
    dividerColor: Colors.grey[700],
    textTheme: const TextTheme(),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(_darkScheme.primary),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return _darkScheme.primary.withOpacity(0.5);
        return Colors.grey.withOpacity(0.2);
      }),
    ),
  );
}
