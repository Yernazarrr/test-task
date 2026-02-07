import 'package:equatable/equatable.dart';

class AuthTokens extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object> get props => [accessToken, refreshToken];
}

class User extends Equatable {
  final String userId;

  const User({required this.userId});

  @override
  List<Object> get props => [userId];
}
