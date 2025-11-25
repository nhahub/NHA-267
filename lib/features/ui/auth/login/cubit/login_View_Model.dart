import 'package:depi_graduation_project/domain/use_case/register_use_case.dart';
import 'package:depi_graduation_project/features/ui/auth/login/cubit/login_states.dart';
import 'package:depi_graduation_project/features/ui/auth/register/cubit/register_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../domain/use_case/login_use_case.dart';

@injectable


class LoginViewModel extends Cubit<LoginStates> {
  LoginUseCase loginUseCase;

  LoginViewModel({required this. loginUseCase})
      : super(LoginInitialState());

  //todo : hold data - handle logic
   TextEditingController emailController = TextEditingController(text: "test.test@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123@#%^&ahmed");
  var formKey = GlobalKey<FormState>();

  void login() async {
    if (formKey.currentState?.validate() == true) {
      emit(LoginLoadingState());
      var either = await loginUseCase.invoke(
          emailController.text.trim(),
          passwordController.text.trim(),
         );
      either.fold((error) {
        emit(LoginErrorState(failers : error));
      }, (response) {
        emit(LoginSuccessState(responseEntity: response));
      });
    }
  }
}
