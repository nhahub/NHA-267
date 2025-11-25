import 'package:depi_graduation_project/domain/entities/LoginResponseEntity.dart';

class LoginResponseDm extends LoginResponseEntity {
  LoginResponseDm({
    super.message,
    super.user,
    super.token,
  });

  LoginResponseDm.fromJson(dynamic json) : super(
    message: json['message'],
    user: json['user'] != null ? LoginUserDM.fromJson(json['user']) : null,
    token: json['token'],
  );
}

class LoginUserDM extends LoginUserEntity {
  LoginUserDM({
    super.name,
    super.email,
    super.phone,
  });

  LoginUserDM.fromJson(dynamic json) : super(
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }
}