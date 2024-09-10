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
import 'package:online_bike_shopping_appuntitled/data/products/data_sources/product_prefUtils.dart'
    as _i39;
import 'package:online_bike_shopping_appuntitled/data/products/data_sources/products_local_data_source.dart'
    as _i540;
import 'package:online_bike_shopping_appuntitled/data/products/data_sources/products_remote_data_source.dart'
    as _i793;
import 'package:online_bike_shopping_appuntitled/data/products/repositories/products_repository_impl.dart'
    as _i128;
import 'package:online_bike_shopping_appuntitled/data/profile/data_sources/profile_local_data_source.dart'
    as _i175;
import 'package:online_bike_shopping_appuntitled/data/profile/data_sources/profile_prefUtils.dart'
    as _i620;
import 'package:online_bike_shopping_appuntitled/data/profile/data_sources/profile_remote_data_source.dart'
    as _i506;
import 'package:online_bike_shopping_appuntitled/data/profile/repositories/profile_repository_impl.dart'
    as _i275;
import 'package:online_bike_shopping_appuntitled/domain/auth/repositories/auth_repository.dart'
    as _i222;
import 'package:online_bike_shopping_appuntitled/domain/products/repositories/products_repository.dart'
    as _i169;
import 'package:online_bike_shopping_appuntitled/domain/profile/repositories/profile_repository.dart'
    as _i338;
import 'package:online_bike_shopping_appuntitled/presentation/auth/bloc/login_bloc/login_bloc.dart'
    as _i727;
import 'package:online_bike_shopping_appuntitled/presentation/auth/bloc/register_bloc/register_bloc.dart'
    as _i695;
import 'package:online_bike_shopping_appuntitled/presentation/products/bloc/product_bloc.dart'
    as _i194;
import 'package:online_bike_shopping_appuntitled/presentation/profile/bloc/profile_bloc.dart'
    as _i958;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => coreModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i454.SupabaseClient>(() => coreModule.supabaseClient);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => coreModule.dataConnectionChecker);
    gh.factory<_i979.AuthRemoteDataSource>(
        () => _i979.AuthRemoteDataSource(gh<_i454.SupabaseClient>()));
    gh.factory<_i620.ProfilePrefUtils>(() => _i620.ProfilePrefUtilsImpl(
        sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i39.PrefUtils>(() =>
        _i39.PrefUtilsImpl(sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i51.NetworkInfo>(
        () => _i51.NetworkInfoImpl(gh<_i973.InternetConnectionChecker>()));
    gh.factory<_i222.AuthRepository>(() => _i616.AuthRepositoryImpl(
          remoteDataSource: gh<_i979.AuthRemoteDataSource>(),
          networkInfo: gh<_i51.NetworkInfo>(),
        ));
    gh.factory<_i175.ProfileLocalDataSource>(() => _i175.ProfileLocalDataSource(
          profilePrefUtils: gh<_i620.ProfilePrefUtils>(),
          networkInfo: gh<_i51.NetworkInfo>(),
        ));
    gh.factory<_i793.ProductsRemoteDataSource>(
        () => _i793.ProductsRemoteDataSource(
              prefUtils: gh<_i39.PrefUtils>(),
              networkInfo: gh<_i51.NetworkInfo>(),
            ));
    gh.factory<_i540.ProductsLocalDataSource>(
        () => _i540.ProductsLocalDataSource(
              prefUtils: gh<_i39.PrefUtils>(),
              networkInfo: gh<_i51.NetworkInfo>(),
            ));
    gh.factory<_i695.RegisterBloc>(
        () => _i695.RegisterBloc(gh<_i222.AuthRepository>()));
    gh.factory<_i506.ProfileRemoteDataSource>(
        () => _i506.ProfileRemoteDataSource(
              prefUtils: gh<_i620.ProfilePrefUtils>(),
              networkInfo: gh<_i51.NetworkInfo>(),
            ));
    gh.factory<_i727.LoginBloc>(
        () => _i727.LoginBloc(authRepository: gh<_i222.AuthRepository>()));
    gh.factory<_i169.ProductsRepository>(() => _i128.ProductsRepositoryImpl(
          remoteDataSource: gh<_i793.ProductsRemoteDataSource>(),
          networkInfo: gh<_i51.NetworkInfo>(),
          localDataSource: gh<_i540.ProductsLocalDataSource>(),
        ));
    gh.factory<_i194.ProductBloc>(
        () => _i194.ProductBloc(repository: gh<_i169.ProductsRepository>()));
    gh.factory<_i338.ProfileRepository>(() => _i275.ProfileRepositoryImpl(
          remoteDataSource: gh<_i506.ProfileRemoteDataSource>(),
          networkInfo: gh<_i51.NetworkInfo>(),
          localDataSource: gh<_i175.ProfileLocalDataSource>(),
        ));
    gh.factory<_i958.ProfileBloc>(
        () => _i958.ProfileBloc(repository: gh<_i338.ProfileRepository>()));
    return this;
  }
}

class _$CoreModule extends _i186.CoreModule {}
