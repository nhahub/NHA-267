import 'package:depi_graduation_project/domain/use_case/register_use_case.dart';
import 'package:depi_graduation_project/features/ui/auth/register/cubit/register_States.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable


class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterUseCase registerUseCase;

  RegisterViewModel({required this.registerUseCase})
      : super(RegisterInitialState());

  //todo : hold data - handle logic
  TextEditingController fullNameController = TextEditingController(text :"michael william");
  TextEditingController phoneController = TextEditingController(text:"01270645990");
  TextEditingController emailController = TextEditingController(text: "mw6873190@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "1717mmm1717@#");
  TextEditingController rePasswordController = TextEditingController(text: "1717mmm1717@#");
  var formKey = GlobalKey<FormState>();

  void register() async {
    if (formKey.currentState?.validate() == true) {
      emit(RegisterLoadingState());
      var either = await registerUseCase.invoke(
          fullNameController.text,
          emailController.text,
          phoneController.text,
          passwordController.text,
          rePasswordController.text);
      either.fold((error) {
        emit(RegisterErrorState(failers : error));
      }, (response) {
        emit(RegisterSuccessState(responseEntity: response));
      });
    }
  }
}
