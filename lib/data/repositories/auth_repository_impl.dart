import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/failures/failures.dart';
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
  return  either.fold((error) => Left(error),
            (response) => Right(response));
  }

}