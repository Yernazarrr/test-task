import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/api_constants.dart';
import 'auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await sharedPreferences.setString(
      StorageConstants.accessToken,
      accessToken,
    );
    await sharedPreferences.setString(
      StorageConstants.refreshToken,
      refreshToken,
    );
  }

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString(StorageConstants.accessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return sharedPreferences.getString(StorageConstants.refreshToken);
  }

  @override
  Future<void> saveUserId(String userId) async {
    await sharedPreferences.setString(StorageConstants.userId, userId);
  }

  @override
  Future<String?> getUserId() async {
    return sharedPreferences.getString(StorageConstants.userId);
  }

  @override
  Future<void> clearTokens() async {
    await sharedPreferences.remove(StorageConstants.accessToken);
    await sharedPreferences.remove(StorageConstants.refreshToken);
    await sharedPreferences.remove(StorageConstants.userId);
  }
}
