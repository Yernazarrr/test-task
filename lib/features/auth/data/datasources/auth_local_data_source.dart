abstract class AuthLocalDataSource {
  Future<void> saveTokens(String accessToken, String refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
  Future<void> clearTokens();
}
