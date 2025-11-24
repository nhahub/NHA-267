import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';

abstract class RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  RegisterResponseEntity responseEntity ;
    RegisterSuccessState  ({required this.responseEntity});}

class RegisterErrorState extends RegisterStates{
  Failers  failers;
  RegisterErrorState({required this.failers});


}