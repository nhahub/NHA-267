// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../core/api/Api_Manager.dart' as _i570;
import '../data/data_sources/remote_data_sources_impl/auth_remote_data_source_impl.dart'
    as _i462;
import '../data/repositories/auth_repository_impl.dart' as _i74;
import '../domain/repositories/data_source/remote_data_source/auth_remote_data_source.dart'
    as _i521;
import '../domain/repositories/repositories/auth_repostiory.dart' as _i66;
import '../domain/use_case/login_use_case.dart' as _i772;
import '../domain/use_case/register_use_case.dart' as _i224;
import '../domain/use_case/reset_password_use_case.dart' as _i276;
import '../domain/use_case/send_otp_use_case.dart' as _i508;
import '../domain/use_case/verify_otp_use_case.dart' as _i484;
import '../features/ui/auth/forgot/cubit/forgot_view_model.dart' as _i549;
import '../features/ui/auth/login/cubit/login_View_Model.dart' as _i902;
import '../features/ui/auth/register/cubit/register_view_model.dart' as _i586;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i570.ApiManager>(() => _i570.ApiManager());
    gh.factory<_i521.AuthRemoteDataSource>(() =>
        _i462.AuthRemoteDataSourceImpl(apimanager: gh<_i570.ApiManager>()));
    gh.factory<_i66.AuthRepository>(() => _i74.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i521.AuthRemoteDataSource>()));
    gh.factory<_i224.RegisterUseCase>(
        () => _i224.RegisterUseCase(gh<_i66.AuthRepository>()));
    gh.factory<_i276.ResetPasswordUseCase>(
        () => _i276.ResetPasswordUseCase(gh<_i66.AuthRepository>()));
    gh.factory<_i508.SendOtpUseCase>(
        () => _i508.SendOtpUseCase(gh<_i66.AuthRepository>()));
    gh.factory<_i484.VerifyOtpUseCase>(
        () => _i484.VerifyOtpUseCase(gh<_i66.AuthRepository>()));
    gh.factory<_i772.LoginUseCase>(
        () => _i772.LoginUseCase(authRepository: gh<_i66.AuthRepository>()));
    gh.factory<_i586.RegisterViewModel>(() =>
        _i586.RegisterViewModel(registerUseCase: gh<_i224.RegisterUseCase>()));
    gh.factory<_i902.LoginViewModel>(
        () => _i902.LoginViewModel(loginUseCase: gh<_i772.LoginUseCase>()));
    gh.factory<_i549.ForgotViewModel>(() => _i549.ForgotViewModel(
          sendOtpUseCase: gh<_i508.SendOtpUseCase>(),
          verifyOtpUseCase: gh<_i484.VerifyOtpUseCase>(),
          resetPasswordUseCase: gh<_i276.ResetPasswordUseCase>(),
        ));
    return this;
  }
}
