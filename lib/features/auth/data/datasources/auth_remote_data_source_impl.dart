import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<void> sendLoginCode(String email) async {
    try {
      await dioClient.dio.post(ApiConstants.login, data: {'email': email});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokensModel> confirmCode(String email, String code) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.confirmCode,
        data: {'email': email, 'code': int.parse(code)},
      );
      return AuthTokensModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AuthTokensModel> refreshToken(String refreshToken) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.refreshToken,
        data: {'token': refreshToken},
      );
      return AuthTokensModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getUser(String accessToken) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.auth,
        options: Options(headers: {'Auth': 'Bearer $accessToken'}),
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (error.type == DioExceptionType.badResponse) {
      return Exception(error.response?.data['message'] ?? 'Server error');
    } else {
      return Exception('Network error');
    }
  }
}
