import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  var dio = Dio(
    BaseOptions(
      // ✅ ده الرابط الجديد بتاعك من Vercel
      baseUrl: 'https://my-backend-depi.vercel.app/',

      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<Response> register(String name, String email, String password, String phone) {
    return dio.post(
      'api/v1/auth/signup',
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
    );
  }

  Future<Response> login(String email, String password) {
    return dio.post(
      'api/v1/auth/signin',
      data: {
        "email": email,
        "password": password
      },
    );
  }
}