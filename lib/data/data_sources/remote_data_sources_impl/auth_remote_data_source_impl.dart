import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/api/Api_Manager.dart';
import 'package:depi_graduation_project/core/api/end_points.dart';

import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/data/model/LoginResponseDM.dart';
import 'package:depi_graduation_project/data/model/RegisterResponseDM.dart';

import 'package:injectable/injectable.dart';

import '../../../../domain/repositories/data_source/remote_data_source/auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apimanager;

  AuthRemoteDataSourceImpl({required this.apimanager});

  @override
  Future<Either<Failers, RegisterResponseDm>> register(String name,
      String email, String password, String rePassword, String phone) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {

        var response = await apimanager.postData(
            endpoint: EndPoints.signUp,
            body: {
              "name": name,
              "email": email,
              "password": password,
              "rePassword": rePassword,
              "phone": phone
            },
            // 🔴 ضروري جداً: نضيف الهيدر هنا كمان عشان التسجيل ينجح
            headers: {
              'Content-Type': 'application/json',
            }
        );
        response.data;
        var registerResponse = RegisterResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(registerResponse);
        } else {
          return Left(ServerError(ErrorMsg: registerResponse.message!));
        }
      } else {
        // todo : no internet connection
        return Left(NetworkError(
            ErrorMsg:
                "No Internet Connection , Please Check Your Internet Connection "));
      }
    } catch (e) {
      return Left(ServerError(ErrorMsg: e.toString()));
    }
  }

  @override
  @override
  Future<Either<Failers, LoginResponseDm>> Login(
      String email, String password) async {
    try {
      final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {

        var response = await apimanager.postData(
            endpoint: EndPoints.signIn,
            body: {
              "email": email,
              "password": password,
            },
            headers: {
              'Content-Type': 'application/json',
            }
        );

        var loginResponseDm = LoginResponseDm.fromJson(response.data);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return Right(loginResponseDm);
        } else {
          return Left(ServerError(ErrorMsg: loginResponseDm.message!));
        }
      } else {
        return Left(NetworkError(ErrorMsg: "No Internet Connection"));
      }
    } catch (e) {
      return Left(Failers(ErrorMsg: e.toString()));
    }
  }
}
