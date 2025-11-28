import 'package:depi_graduation_project/core/failures/failures.dart';

abstract class ForgotStates {}

class ForgotInitialState extends ForgotStates {}

class ForgotLoadingState extends ForgotStates {}

class ForgotOtpSentState extends ForgotStates {}

class ForgotOtpVerifiedState extends ForgotStates {}

class ForgotPasswordResetState extends ForgotStates {}

class ForgotErrorState extends ForgotStates {
  final Failers failers;
  ForgotErrorState({required this.failers});
}
