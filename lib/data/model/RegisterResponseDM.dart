import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';

class RegisterResponseDm extends RegisterResponseEntity {
  RegisterResponseDm({
    super.message,
    super.user,
    super.token,
  });

  RegisterResponseDm.fromJson(dynamic json) : super(
    message: json['message'],
    user: json['user'] != null ? UserDM.fromJson(json['user']) : null,
    token: json['token'],
  );
}

class UserDM extends UserEntity {
  //  UserEntity
  UserDM({
    super.id,
    super.name,
    super.email,
    super.phone,
  });

  UserDM.fromJson(dynamic json) : super(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    // ❌ شيلنا سطر الباسورد من هنا لأن الـ Entity مش محتاجه
    // حتى لو الـ JSON راجع فيه باسورد، احنا هنتجاهله هنا
  );
}