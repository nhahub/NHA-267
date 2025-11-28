import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/domain/repositories/repositories/auth_repostiory.dart';
import 'package:injectable/injectable.dart';

@injectable
class SendOtpUseCase {
  final AuthRepository authRepository;

  SendOtpUseCase(this.authRepository);

  Future<Either<Failers, Unit>> invoke(String phone) {
    return authRepository.sendOtpToPhone(phone);
  }
}
