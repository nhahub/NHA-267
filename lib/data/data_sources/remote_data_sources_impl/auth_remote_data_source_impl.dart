import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/api/Api_Manager.dart';
import 'package:depi_graduation_project/core/api/end_points.dart';

import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/data/model/RegisterResponseDM.dart';

import 'package:depi_graduation_project/domain/entities/RegisterResponseEntity.dart';

import '../../../../domain/repositories/data_source/remote_data_source/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apimanager;

  AuthRemoteDataSourceImpl({required this.apimanager});

  @override
  Future<Either<Failers, RegisterResponseDm>> register(String name,
      String email, String password, String rePassword, String phone) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile)) {
      // todo : internet connection

      var response =
          await apimanager.postData(endpoint: EndPoints.signUp, body: {
        "name": name,
        "email": email,
        "password": password,
        "rePassword": rePassword,
        "phone": phone
      });
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
  }
}
