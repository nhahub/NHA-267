import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 💡 لإدارة البيانات المحلية

import '../../domain/repositories/auth_repository.dart';

// 💡 مفتاح حفظ اسم المستخدم في SharedPreferences
const String kUserNameKey = 'user_name';

class AuthRepositoryImpl implements AuthRepository {

  // ----------------------------------------------------
  // 1. التسجيل (Mock) - نقوم بحفظ الاسم هنا
  // ----------------------------------------------------
  @override
  Future<Either<String, void>> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // 💡 تخزين اسم المستخدم في الذاكرة (SharedPreferences)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(kUserNameKey, fullName);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ----------------------------------------------------
  // 2. تسجيل الدخول (Mock) - نقوم بحفظ الاسم هنا
  // ----------------------------------------------------
  @override
  Future<Either<String, void>> loginUser({
    required String username,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username.isNotEmpty && password.isNotEmpty) {
      // 💡 تخزين اسم المستخدم المدخل كـ 'اسم المستخدم'
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(kUserNameKey, username);
      return const Right(null);
    } else {
      return const Left("Invalid username or password.");
    }
  }

  // ----------------------------------------------------
  // 3. استرجاع الاسم من الذاكرة
  // ----------------------------------------------------
  @override
  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(kUserNameKey);
  }
}