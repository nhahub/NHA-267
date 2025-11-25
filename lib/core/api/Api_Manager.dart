import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_constants.dart';

@singleton
class ApiManager {
  Dio dio = Dio()
    ..interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,  // ⬅️ ده هيورينا البيانات اللي مبعوتة بالظبط
      responseHeader: true,
      responseBody: true, // ⬅️ ده هيورينا رد السيرفر بالتفصيل
      error: true,
    ));

  Future<Response> getData({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Option? options,
    Map<String, dynamic>? headers,
  }) {
    return dio.get(
      ApiConstants.baseurl + endpoint,
      queryParameters: queryParameters,
      options: Options(headers: headers,
      validateStatus: (status)=>true),
    );
  }

  Future<Response> postData({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Option? options,
    Object? body,
    Map<String, dynamic>? headers,
  }) {
    return dio.post(
      ApiConstants.baseurl + endpoint,
      queryParameters: queryParameters,
      data: body,
      options: Options(headers: headers,
      validateStatus: (status)=>true  ),
    );
  }

// Future<Response> register(String name, String email, String password, String phone) {
//   return dio.post(
//     'api/v1/auth/signup',
//     data: {
//       "name": name,
//       "email": email,
//       "password": password,
//       "rePassword": password,
//       "phone": phone,
//     },
//   );
// }

// Future<Response> login(String email, String password) {
//   return dio.post(
//     'api/v1/auth/signin',
//     data: {
//       "email": email,
//       "password": password
//     },
//   );
// }
}
