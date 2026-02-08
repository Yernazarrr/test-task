import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthTokensModel extends AuthTokens {
  @JsonKey(name: 'jwt')
  final String jwt;

  @JsonKey(name: 'refresh_token')
  final String rt;

  const AuthTokensModel({required this.jwt, required this.rt})
    : super(accessToken: jwt, refreshToken: rt);

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokensModelToJson(this);
}
