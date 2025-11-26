import 'package:depi_graduation_project/core/failures/failures.dart';

import '../../../../../domain/entities/LoginResponseEntity.dart';

abstract class LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginSuccessState extends LoginStates{
   LoginResponseEntity responseEntity ;
  LoginSuccessState  ({required this.responseEntity});}

class LoginErrorState extends LoginStates{
  Failers  failers;
  LoginErrorState({required this.failers});


}