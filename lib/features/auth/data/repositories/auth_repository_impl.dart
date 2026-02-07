import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> sendLoginCode(String email) async {
    try {
      await remoteDataSource.sendLoginCode(email);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> confirmCode(
    String email,
    String code,
  ) async {
    try {
      final tokens = await remoteDataSource.confirmCode(email, code);
      await localDataSource.saveTokens(tokens.accessToken, tokens.refreshToken);
      return Right(tokens);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthTokens>> refreshToken(String refreshToken) async {
    try {
      final tokens = await remoteDataSource.refreshToken(refreshToken);
      await localDataSource.saveTokens(tokens.accessToken, tokens.refreshToken);
      return Right(tokens);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(String accessToken) async {
    try {
      final user = await remoteDataSource.getUser(accessToken);
      await localDataSource.saveUserId(user.userId);
      return Right(user);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearTokens();
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await localDataSource.getAccessToken();
      return Right(token != null && token.isNotEmpty);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getStoredAccessToken() async {
    try {
      final token = await localDataSource.getAccessToken();
      return Right(token);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getStoredRefreshToken() async {
    try {
      final token = await localDataSource.getRefreshToken();
      return Right(token);
    } on Exception catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
