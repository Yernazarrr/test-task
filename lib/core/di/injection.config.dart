// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/datasources/auth_local_data_source.dart' as _i1025;
import '../../features/auth/data/datasources/auth_local_data_source_impl.dart' as _i872;
import '../../features/auth/data/datasources/auth_remote_data_source.dart' as _i750;
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart' as _i651;
import '../../features/auth/data/repositories/auth_repository_impl.dart' as _i840;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i145;
import '../../features/auth/domain/usecases/check_authentication.dart' as _i341;
import '../../features/auth/domain/usecases/confirm_code.dart' as _i836;
import '../../features/auth/domain/usecases/get_user.dart' as _i619;
import '../../features/auth/domain/usecases/logout.dart' as _i829;
import '../../features/auth/domain/usecases/refresh_token.dart' as _i997;
import '../../features/auth/domain/usecases/send_login_code.dart' as _i476;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i608;
import '../network/dio_client.dart' as _i361;

extension GetItInjectableX on _i174.GetIt {
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i361.DioClient>(() => _i361.DioClient());
    gh.factory<_i1025.AuthLocalDataSource>(
        () => _i872.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i750.AuthRemoteDataSource>(
        () => _i651.AuthRemoteDataSourceImpl(gh<_i361.DioClient>()));
    gh.factory<_i145.AuthRepository>(() => _i840.AuthRepositoryImpl(
          remoteDataSource: gh<_i750.AuthRemoteDataSource>(),
          localDataSource: gh<_i1025.AuthLocalDataSource>(),
        ));
    gh.factory<_i476.SendLoginCode>(
        () => _i476.SendLoginCode(gh<_i145.AuthRepository>()));
    gh.factory<_i836.ConfirmCode>(
        () => _i836.ConfirmCode(gh<_i145.AuthRepository>()));
    gh.factory<_i619.GetUser>(() => _i619.GetUser(gh<_i145.AuthRepository>()));
    gh.factory<_i829.Logout>(() => _i829.Logout(gh<_i145.AuthRepository>()));
    gh.factory<_i341.CheckAuthentication>(
        () => _i341.CheckAuthentication(gh<_i145.AuthRepository>()));
    gh.factory<_i997.RefreshTokenUseCase>(
        () => _i997.RefreshTokenUseCase(gh<_i145.AuthRepository>()));
    gh.factory<_i608.AuthBloc>(() => _i608.AuthBloc(
          sendLoginCode: gh<_i476.SendLoginCode>(),
          confirmCode: gh<_i836.ConfirmCode>(),
          getUser: gh<_i619.GetUser>(),
          logout: gh<_i829.Logout>(),
          checkAuthentication: gh<_i341.CheckAuthentication>(),
          refreshTokenUseCase: gh<_i997.RefreshTokenUseCase>(),
          authRepository: gh<_i145.AuthRepository>(),
        ));
    return this;
  }
}
