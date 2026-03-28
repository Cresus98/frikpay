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
      profil: json['profil'] as String?,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'country_prefix': instance.country_prefix,
      'company': instance.company,
      'telephone': instance.telephone,
      'profil': instance.profil,
    };
