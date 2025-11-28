import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/domain/entities/LoginResponseEntity.dart';
import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';
import 'package:depi_graduation_project/domain/repositories/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:depi_graduation_project/domain/repositories/repositories/auth_repostiory.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failers, RegisterResponseEntity>> register(String name,
      String email, String password, String rePassword, String phone) async {
    var either = await authRemoteDataSource.register(
        name, email, password, rePassword, phone);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failers, LoginResponseEntity>> Login(
      String email, String password) async {
    var either = await authRemoteDataSource.Login(email, password);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failers, Unit>> sendOtpToPhone(String phone) async {
    return await authRemoteDataSource.sendOtpToPhone(phone);
  }

  @override
  Future<Either<Failers, Unit>> verifyOtpCode(String phone, String otp) async {
    return await authRemoteDataSource.verifyOtpCode(phone, otp);
  }

  @override
  Future<Either<Failers, Unit>> resetPasswordWithOtp(
      String phone, String otp, String newPassword) async {
    return await authRemoteDataSource.resetPasswordWithOtp(
        phone, otp, newPassword);
  }
}
