import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'appuser.freezed.dart';
part 'appuser.g.dart';


@freezed
class AppUser with _$AppUser
{
  factory AppUser({
    required String firstname,
    required String lastname,
    String ? email,
    String ? country_prefix,
    String ? company,
    String ? telephone,
    String ? profil,
  })=_AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json)=>_$AppUserFromJson(json);
}