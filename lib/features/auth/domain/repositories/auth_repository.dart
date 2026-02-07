import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> sendLoginCode(String email);
  Future<Either<Failure, AuthTokens>> confirmCode(String email, String code);
  Future<Either<Failure, AuthTokens>> refreshToken(String refreshToken);
  Future<Either<Failure, User>> getUser(String accessToken);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, String?>> getStoredAccessToken();
  Future<Either<Failure, String?>> getStoredRefreshToken();
}
