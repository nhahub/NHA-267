import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';

/// message : "تم تسجيل الدخول بنجاح"
/// user : {"id":1,"name":"Ahmed Ali","email":"ahmed@test.com","password":"password123","phone":"01012345678"}
/// token : "fake-jwt-token-1763899710284"

class RegisterResponseDm extends RegisterResponseEntity {
  RegisterResponseDm({
    super.message,
    super.user,
    super.token,
  });

  RegisterResponseDm.fromJson(dynamic json) {
    message = json['message'];

    user = json['user'] != null ? UserDM.fromJson(json['user']) : null;
    token = json['token'];
  }
}

/// id : 1
/// name : "Ahmed Ali"
/// email : "ahmed@test.com"
/// password : "password123"
/// phone : "01012345678"

class UserDM extends UserEntity {
  UserDM({
    this.id,
    super.name,
    super.email,
    this.password,
    this.phone,
  });

  UserDM.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }

  int? id;
  String? password;
  String? phone;
}
