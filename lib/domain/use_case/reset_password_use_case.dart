import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/domain/repositories/repositories/auth_repostiory.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  Future<Either<Failers, Unit>> invoke(
      String phone, String otp, String newPassword) {
    return authRepository.resetPasswordWithOtp(phone, otp, newPassword);
  }
}
