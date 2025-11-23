class RegisterResponseEntity {
  RegisterResponseEntity({
    this.message,
    this.user,
    this.token,
  });

  String? message;
  UserEntity? user;
  String? token;
}

class UserEntity {
  UserEntity({
    this.id,      // ✅ ضفنا الـ id هنا عشان نقدر نستخدمه في الـ UI
    this.name,
    this.email,
    this.phone,   // ✅ ضفنا الـ phone هنا عشان نعرضه في البروفايل
  });

  int? id;
  String? name;
  String? email;
  String? phone;
// ملحوظة: الباسورد مش بنحتاجه في الـ Entity عادةً لأمان التطبيق
}