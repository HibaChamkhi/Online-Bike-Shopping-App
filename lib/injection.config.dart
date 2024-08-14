// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:online_bike_shopping_appuntitled/core/di/core_module.dart'
    as _i186;
import 'package:online_bike_shopping_appuntitled/core/network/network_info.dart'
    as _i51;
import 'package:online_bike_shopping_appuntitled/data/auth/data_sources/auth_remote_data_source.dart'
    as _i979;
import 'package:online_bike_shopping_appuntitled/data/auth/repositories/auth_repository_impl.dart'
    as _i616;
import 'package:online_bike_shopping_appuntitled/domain/auth/repositories/auth_repository.dart'
    as _i222;
import 'package:online_bike_shopping_appuntitled/presentation/auth/bloc/login_bloc/login_bloc.dart'
    as _i727;

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
    final coreModule = _$CoreModule();
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => coreModule.dataConnectionChecker);
    gh.factory<_i979.AuthRemoteDataSource>(
        () => _i979.AuthRemoteDataSourceImpl());
    gh.factory<_i51.NetworkInfo>(
        () => _i51.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.factory<_i222.AuthRepository>(() => _i616.AuthRepositoryImpl(
          remoteDataSource: gh<_i979.AuthRemoteDataSource>(),
          networkInfo: gh<_i51.NetworkInfo>(),
        ));
    gh.factory<_i727.LoginBloc>(
        () => _i727.LoginBloc(authRepository: gh<_i222.AuthRepository>()));
    return this;
  }
}

class _$CoreModule extends _i186.CoreModule {}
