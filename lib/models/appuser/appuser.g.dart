// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String? ?? '',
      login: json['login'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      telephone: json['telephone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      profil_id: json['profil_id'] as String? ?? '',
      rang_id: json['rang_id'] as String? ?? '',
      company: json['company'] as String? ?? '',
      country_prefix: json['country_prefix'] as String? ?? '',
      code: json['code'] as String? ?? '',
      sexe: json['sexe'] as String? ?? '',
      photo_profil: json['photo_profil'] as String? ?? '',
      signature: json['signature'] as String? ?? '',
      is_active: json['is_active'] as String? ?? '',
      timezone_id: json['timezone_id'] as String? ?? '',
      created: json['created'] as String? ?? '',
      modified: json['modified'] as String? ?? '',
      last_connexion: json['last_connexion'] as String? ?? '',
      last_ip: json['last_ip'] as String? ?? '',
      last_agent: json['last_agent'] as String? ?? '',
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'telephone': instance.telephone,
      'email': instance.email,
      'profil_id': instance.profil_id,
      'rang_id': instance.rang_id,
      'company': instance.company,
      'country_prefix': instance.country_prefix,
      'code': instance.code,
      'sexe': instance.sexe,
      'photo_profil': instance.photo_profil,
      'signature': instance.signature,
      'is_active': instance.is_active,
      'timezone_id': instance.timezone_id,
      'created': instance.created,
      'modified': instance.modified,
      'last_connexion': instance.last_connexion,
      'last_ip': instance.last_ip,
      'last_agent': instance.last_agent,
    };
