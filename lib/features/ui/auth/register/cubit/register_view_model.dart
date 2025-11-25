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
  TextEditingController fullNameController = TextEditingController(text :"انا احمد");
  TextEditingController phoneController = TextEditingController(text:"01234567890");
  TextEditingController emailController = TextEditingController(text: "test.test@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123@#%^&ahmed");
  TextEditingController rePasswordController = TextEditingController(text: "123@#%^&ahmed");
  var formKey = GlobalKey<FormState>();

  void register() async {
    if (formKey.currentState?.validate() == true) {
      emit(RegisterLoadingState());

      // هنا الترتيب الصحيح
      var either = await registerUseCase.invoke(
        fullNameController.text,   // 1. الاسم
        emailController.text,      // 2. الإيميل
        passwordController.text,   // 3. الباسورد (تأكد إنه التالت)
        rePasswordController.text, // 4. إعادة الباسورد
        phoneController.text,      // 5. الهاتف (تأكد إنه الخامس والأخير)
      );

      either.fold((error) {
        emit(RegisterErrorState(failers : error));
      }, (response) {
        emit(RegisterSuccessState(responseEntity: response));
      });
    }
  }
}
