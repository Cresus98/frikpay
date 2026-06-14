// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DevAccount _$DevAccountFromJson(Map<String, dynamic> json) {
  return _DevAccount.fromJson(json);
}

/// @nodoc
mixin _$DevAccount {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get user_id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get created => throw _privateConstructorUsedError;
  String get modified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DevAccountCopyWith<DevAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevAccountCopyWith<$Res> {
  factory $DevAccountCopyWith(
          DevAccount value, $Res Function(DevAccount) then) =
      _$DevAccountCopyWithImpl<$Res, DevAccount>;
  @useResult
  $Res call(
      {String id,
      String name,
      String token,
      String user_id,
      String status,
      String created,
      String modified});
}

/// @nodoc
class _$DevAccountCopyWithImpl<$Res, $Val extends DevAccount>
    implements $DevAccountCopyWith<$Res> {
  _$DevAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? token = null,
    Object? user_id = null,
    Object? status = null,
    Object? created = null,
    Object? modified = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevAccountImplCopyWith<$Res>
    implements $DevAccountCopyWith<$Res> {
  factory _$$DevAccountImplCopyWith(
          _$DevAccountImpl value, $Res Function(_$DevAccountImpl) then) =
      __$$DevAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String token,
      String user_id,
      String status,
      String created,
      String modified});
}

/// @nodoc
class __$$DevAccountImplCopyWithImpl<$Res>
    extends _$DevAccountCopyWithImpl<$Res, _$DevAccountImpl>
    implements _$$DevAccountImplCopyWith<$Res> {
  __$$DevAccountImplCopyWithImpl(
      _$DevAccountImpl _value, $Res Function(_$DevAccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? token = null,
    Object? user_id = null,
    Object? status = null,
    Object? created = null,
    Object? modified = null,
  }) {
    return _then(_$DevAccountImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      user_id: null == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as String,
      modified: null == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DevAccountImpl with DiagnosticableTreeMixin implements _DevAccount {
  const _$DevAccountImpl(
      {this.id = '',
      this.name = '',
      this.token = '',
      this.user_id = '',
      this.status = '',
      this.created = '',
      this.modified = ''});

  factory _$DevAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$DevAccountImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String token;
  @override
  @JsonKey()
  final String user_id;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String created;
  @override
  @JsonKey()
  final String modified;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DevAccount(id: $id, name: $name, token: $token, user_id: $user_id, status: $status, created: $created, modified: $modified)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DevAccount'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('user_id', user_id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('created', created))
      ..add(DiagnosticsProperty('modified', modified));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevAccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.modified, modified) ||
                other.modified == modified));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, token, user_id, status, created, modified);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DevAccountImplCopyWith<_$DevAccountImpl> get copyWith =>
      __$$DevAccountImplCopyWithImpl<_$DevAccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DevAccountImplToJson(
      this,
    );
  }
}

abstract class _DevAccount implements DevAccount {
  const factory _DevAccount(
      {final String id,
      final String name,
      final String token,
      final String user_id,
      final String status,
      final String created,
      final String modified}) = _$DevAccountImpl;

  factory _DevAccount.fromJson(Map<String, dynamic> json) =
      _$DevAccountImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get token;
  @override
  String get user_id;
  @override
  String get status;
  @override
  String get created;
  @override
  String get modified;
  @override
  @JsonKey(ignore: true)
  _$$DevAccountImplCopyWith<_$DevAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
