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
import '../domain/use_case/register_use_case.dart' as _i224;
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
    gh.factory<_i586.RegisterViewModel>(() =>
        _i586.RegisterViewModel(registerUseCase: gh<_i224.RegisterUseCase>()));
    return this;
  }
}
