class ApiConstants {
  static const String baseUrl =
      'https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net';

  static const String login = '/login';
  static const String confirmCode = '/confirm_code';
  static const String refreshToken = '/refresh_token';
  static const String auth = '/auth';

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
}

class StorageConstants {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
}
