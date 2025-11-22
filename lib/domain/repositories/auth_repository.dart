import 'package:dartz/dartz.dart';

// 💡 واجهة Repository الأساسية للـ Authentication
abstract class AuthRepository {
  // 1. التسجيل (Mock)
  Future<Either<String, void>> registerUser({
    required String fullName,
    required String email,
    required String password,
  });

  // 2. تسجيل الدخول (Mock)
  Future<Either<String, void>> loginUser({
    required String username,
    required String password,
  });

  // 3. استرجاع الاسم من الذاكرة
  Future<String?> getUserName();
}