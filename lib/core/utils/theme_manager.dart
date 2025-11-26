import 'package:flutter/material.dart';
import 'package:depi_graduation_project/core/cache/SharedPreference.dart';

class ThemeManager {
  static final ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

  static Future<void> init() async {
    final stored = SharedPreferenceUtils.getData(key: 'isDark');
    if (stored is bool) {
      isDark.value = stored;
    }
  }

  static void toggleTheme() {
    isDark.value = !isDark.value;
    SharedPreferenceUtils.saveData(key: 'isDark', value: isDark.value);
  }
}
