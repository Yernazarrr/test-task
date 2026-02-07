// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthTokensModel _$AuthTokensModelFromJson(Map<String, dynamic> json) =>
    AuthTokensModel(
      jwt: json['jwt'] as String,
      rt: json['refresh_token'] as String,
    );

Map<String, dynamic> _$AuthTokensModelToJson(AuthTokensModel instance) =>
    <String, dynamic>{'jwt': instance.jwt, 'refresh_token': instance.rt};

UserModel _$UserModelFromJson(Map<String, dynamic> json) =>
    UserModel(id: json['user_id'] as String);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'user_id': instance.id,
};
