import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'appuser.freezed.dart';
part 'appuser.g.dart';


@freezed
class AppUser with _$AppUser {
  factory AppUser({
    required String firstname,
    required String lastname,
    String? id,
    String? login,
    String? email,
    String? country_prefix,
    String? company,
    String? telephone,
    String? profil_id,
    String? photo_profil,
    String? is_active,
    String? rang_id,
    String? sexe,
    String? code,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}