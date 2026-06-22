import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'dev_account.freezed.dart';
part 'dev_account.g.dart';

@freezed
class DevAccount with _$DevAccount {
  const factory DevAccount({
    @Default('') String id,
    @Default('') String name,
    @Default('') String token,
    @Default('') String user_id,
    @Default('') String status,
    @Default('') String created,
    @Default('') String modified,
  }) = _DevAccount;

  factory DevAccount.fromJson(Map<String, dynamic> json) =>
      _$DevAccountFromJson(json);
}
