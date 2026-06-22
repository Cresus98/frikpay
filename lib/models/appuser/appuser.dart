import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'appuser.freezed.dart';
part 'appuser.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    @Default('') String id,
    @Default('') String login,
    @Default('') String firstname,
    @Default('') String lastname,
    @Default('') String telephone,
    @Default('') String email,
    @Default('') String profil_id,
    @Default('') String rang_id,
    @Default('') String company,
    @Default('') String country_prefix,
    @Default('') String code,
    @Default('') String sexe,
    @Default('') String photo_profil,
    @Default('') String signature,
    @Default('') String is_active,
    @Default('') String timezone_id,
    @Default('') String created,
    @Default('') String modified,
    @Default('') String last_connexion,
    @Default('') String last_ip,
    @Default('') String last_agent,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}