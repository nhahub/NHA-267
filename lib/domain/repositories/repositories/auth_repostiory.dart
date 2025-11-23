import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';

import '../../../core/failures/failures.dart';

abstract class AuthRepository {
  Future<Either<Failers, RegisterResponseEntity>> register(String name, String email,
      String password, String rePassword, String phone);
}
