import '../models/auth_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> sendLoginCode(String email);
  Future<AuthTokensModel> confirmCode(String email, String code);
  Future<AuthTokensModel> refreshToken(String refreshToken);
  Future<UserModel> getUser(String accessToken);
}
