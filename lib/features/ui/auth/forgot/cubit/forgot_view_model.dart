import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_case/send_otp_use_case.dart';
import '../../../../../domain/use_case/verify_otp_use_case.dart';
import '../../../../../domain/use_case/reset_password_use_case.dart';
import 'forgot_states.dart';

@injectable
class ForgotViewModel extends Cubit<ForgotStates> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  ForgotViewModel({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.resetPasswordUseCase,
  }) : super(ForgotInitialState());

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final reNewPasswordController = TextEditingController();

  final sendFormKey = GlobalKey<FormState>();
  final resetFormKey = GlobalKey<FormState>();

  Future<void> sendOtp() async {
    if (sendFormKey.currentState?.validate() != true) return;
    emit(ForgotLoadingState());
    final res = await sendOtpUseCase.invoke(phoneController.text.trim());
    res.fold((e) => emit(ForgotErrorState(failers: e)),
        (_) => emit(ForgotOtpSentState()));
  }

  Future<void> verifyOtp() async {
    emit(ForgotLoadingState());
    final res = await verifyOtpUseCase.invoke(
      phoneController.text.trim(),
      otpController.text.trim(),
    );
    res.fold((e) => emit(ForgotErrorState(failers: e)),
        (_) => emit(ForgotOtpVerifiedState()));
  }

  Future<void> resetPassword() async {
    if (resetFormKey.currentState?.validate() != true) return;
    emit(ForgotLoadingState());
    final res = await resetPasswordUseCase.invoke(
      phoneController.text.trim(),
      otpController.text.trim(),
      newPasswordController.text.trim(),
    );
    res.fold((e) => emit(ForgotErrorState(failers: e)),
        (_) => emit(ForgotPasswordResetState()));
  }
}
