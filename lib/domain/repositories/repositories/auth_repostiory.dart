import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/domain/entities/LoginResponseEntity.dart';
import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';

import '../../../core/failures/failures.dart';

abstract class AuthRepository {
  Future<Either<Failers, RegisterResponseEntity>> register(String name,
      String email, String password, String rePassword, String phone);
  Future<Either<Failers, LoginResponseEntity>> Login(
      String email, String password);

  // Forgot password methods
  Future<Either<Failers, Unit>> sendOtpToPhone(String phone);
  Future<Either<Failers, Unit>> verifyOtpCode(String phone, String otp);
  Future<Either<Failers, Unit>> resetPasswordWithOtp(
      String phone, String otp, String newPassword);
}
