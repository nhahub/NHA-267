import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';

abstract class AuthRepository {
  // 1. التسجيل
  // ✅ التعديل: أضفنا required لكل الحقول
  Future<Either<Failers, RegisterResponseEntity>> register({
    required String fullName,
    required String email,
    required String password,
    required String rePassword,
  });

  // 2. تسجيل الدخول
  Future<Either<String, void>> login({
    required String username,
    required String password,
  });

  // 3. استرجاع الاسم
  Future<String?> getUserName();
}