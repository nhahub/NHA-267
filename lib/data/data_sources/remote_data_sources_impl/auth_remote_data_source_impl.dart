import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:depi_graduation_project/core/api/Api_Manager.dart';
import 'package:depi_graduation_project/core/api/end_points.dart';

import 'package:depi_graduation_project/core/failures/failures.dart';
import 'package:depi_graduation_project/data/model/LoginResponseDM.dart';
import 'package:depi_graduation_project/data/model/RegisterResponseDM.dart';

import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../domain/repositories/data_source/remote_data_source/auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apimanager;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Store verification ID for phone auth
  String? _verificationId;

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
            headers: {
              'Content-Type': 'application/json',
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
    } catch (e) {
      return Left(ServerError(ErrorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failers, LoginResponseDm>> Login(
      String email, String password) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        var response =
            await apimanager.postData(endpoint: EndPoints.signIn, body: {
          "email": email,
          "password": password,
        }, headers: {
          'Content-Type': 'application/json',
        });

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

  @override
  Future<Either<Failers, Unit>> sendOtpToPhone(String phone) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        // For web testing: Use mock verification for test number
        if (kIsWeb && (phone == '01111111111' || phone == '+201111111111')) {
          _verificationId = 'web-test-verification-id';
          await Future.delayed(const Duration(milliseconds: 500));
          return const Right(unit);
        }

        // Format phone number with country code
        String formattedPhone = phone.startsWith('+') ? phone : '+20$phone';

        // Use Completer to handle async callbacks
        final Completer<Either<Failers, Unit>> completer = Completer();

        await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: formattedPhone,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Auto-retrieval or instant verification (mainly for Android)
            if (!completer.isCompleted) {
              _verificationId = 'auto-verified';
              completer.complete(const Right(unit));
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            // Handle error
            if (!completer.isCompleted) {
              String errorMessage = e.message ?? 'فشل إرسال كود التحقق';
              if (e.code == 'invalid-phone-number') {
                errorMessage = 'رقم الهاتف غير صحيح';
              } else if (e.code == 'too-many-requests') {
                errorMessage =
                    'تم إرسال عدد كبير من الطلبات. حاول مرة أخرى لاحقاً';
              }
              completer.complete(Left(ServerError(ErrorMsg: errorMessage)));
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            _verificationId = verificationId;
            if (!completer.isCompleted) {
              completer.complete(const Right(unit));
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            _verificationId = verificationId;
          },
        );

        // Wait for the result from callbacks
        return await completer.future;
      } else {
        return Left(NetworkError(ErrorMsg: "No Internet Connection"));
      }
    } catch (e) {
      return Left(ServerError(ErrorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failers, Unit>> verifyOtpCode(String phone, String otp) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        // For web testing: Validate test credentials
        if (kIsWeb && _verificationId == 'web-test-verification-id') {
          if (otp == '123456') {
            return const Right(unit);
          } else {
            return Left(ServerError(ErrorMsg: 'كود التحقق غير صحيح'));
          }
        }

        if (_verificationId == null) {
          return Left(ServerError(
              ErrorMsg: "Verification ID not found. Please resend OTP."));
        }

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: otp,
        );

        // Verify the credential
        await _firebaseAuth.signInWithCredential(credential);

        return const Right(unit);
      } else {
        return Left(NetworkError(ErrorMsg: "No Internet Connection"));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(ServerError(ErrorMsg: e.message ?? 'Invalid OTP'));
      }
      return Left(ServerError(ErrorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failers, Unit>> resetPasswordWithOtp(
      String phone, String otp, String newPassword) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        // For web testing: Simply return success for test credentials
        if (kIsWeb && _verificationId == 'web-test-verification-id') {
          await Future.delayed(const Duration(milliseconds: 500));
          return const Right(unit);
        }

        User? user = _firebaseAuth.currentUser;

        if (user == null) {
          return Left(ServerError(
              ErrorMsg: "User not authenticated. Please verify OTP first."));
        }

        // Update password
        await user.updatePassword(newPassword);

        // Sign out after password reset
        await _firebaseAuth.signOut();

        return const Right(unit);
      } else {
        return Left(NetworkError(ErrorMsg: "No Internet Connection"));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Left(
            ServerError(ErrorMsg: e.message ?? 'Failed to reset password'));
      }
      return Left(ServerError(ErrorMsg: e.toString()));
    }
  }
}
