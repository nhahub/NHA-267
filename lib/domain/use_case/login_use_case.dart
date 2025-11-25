import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/domain/repositories/repositories/auth_repostiory.dart';
import 'package:injectable/injectable.dart';

import '../../core/failures/failures.dart';
import '../entities/LoginResponseEntity.dart';
@injectable
class LoginUseCase{
  AuthRepository authRepository ;
  LoginUseCase({required this.authRepository});
  Future<Either<Failers, LoginResponseEntity>>invoke (String email,String password){
  return authRepository.Login(email, password);

}

}