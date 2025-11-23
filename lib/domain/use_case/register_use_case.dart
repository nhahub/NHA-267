import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/domain/repositories/repositories/auth_repostiory.dart';

import '../../core/failures/failures.dart';
import '../entities/RegisterResponseEntity.dart';

class RegisterUseCase{
  AuthRepository authRepository;
  RegisterUseCase(this.authRepository);

  Future<Either<Failers, RegisterResponseEntity>>invoke(
      String name,
      String email,
      String password,
      String rePassword,
      String phone,
      ){
    return authRepository.register(name, email, password, rePassword, phone);

  }

}