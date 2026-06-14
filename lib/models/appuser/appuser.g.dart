// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appuser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String?,
      country_prefix: json['country_prefix'] as String?,
      company: json['company'] as String?,
      telephone: json['telephone'] as String?,
      profil_id: json['profil_id'] as String?,
      photo_profil: json['photo_profil'] as String?,
      is_active: json['is_active'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'country_prefix': instance.country_prefix,
      'company': instance.company,
      'telephone': instance.telephone,
      'profil_id': instance.profil_id,
      'photo_profil': instance.photo_profil,
      'is_active': instance.is_active,
    };
