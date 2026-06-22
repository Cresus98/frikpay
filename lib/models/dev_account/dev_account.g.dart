// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DevAccountImpl _$$DevAccountImplFromJson(Map<String, dynamic> json) =>
    _$DevAccountImpl(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      token: json['token'] as String? ?? '',
      user_id: json['user_id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      created: json['created'] as String? ?? '',
      modified: json['modified'] as String? ?? '',
    );

Map<String, dynamic> _$$DevAccountImplToJson(_$DevAccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'token': instance.token,
      'user_id': instance.user_id,
      'status': instance.status,
      'created': instance.created,
      'modified': instance.modified,
    };
