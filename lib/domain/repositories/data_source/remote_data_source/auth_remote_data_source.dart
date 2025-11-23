import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/failures/failures.dart';

import '../../../entities/RegisterResponseEntity.dart';

abstract class AuthRemoteDataSource{
  Future<Either<Failers, RegisterResponseEntity>> register(String name, String email,
      String password, String rePassword, String phone);
}