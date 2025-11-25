class LoginResponseEntity {
  LoginResponseEntity({
      this.message, 
      this.user, 
      this.token,});

  String? message;
  LoginUserEntity? user;
  String? token;


}

class LoginUserEntity {
  LoginUserEntity({
      this.name,
      this.email, 
      this.phone,});

  String? name;
  String? email;
  String? phone;


}