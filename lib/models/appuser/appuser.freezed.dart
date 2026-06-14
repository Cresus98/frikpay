// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appuser.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get firstname => throw _privateConstructorUsedError;
  String get lastname => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get country_prefix => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get telephone => throw _privateConstructorUsedError;
  String? get profil_id => throw _privateConstructorUsedError;
  String? get photo_profil => throw _privateConstructorUsedError;
  String? get is_active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String firstname,
      String lastname,
      String? email,
      String? country_prefix,
      String? company,
      String? telephone,
      String? profil_id,
      String? photo_profil,
      String? is_active});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstname = null,
    Object? lastname = null,
    Object? email = freezed,
    Object? country_prefix = freezed,
    Object? company = freezed,
    Object? telephone = freezed,
    Object? profil_id = freezed,
    Object? photo_profil = freezed,
    Object? is_active = freezed,
  }) {
    return _then(_value.copyWith(
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      country_prefix: freezed == country_prefix
          ? _value.country_prefix
          : country_prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      telephone: freezed == telephone
          ? _value.telephone
          : telephone // ignore: cast_nullable_to_non_nullable
              as String?,
      profil_id: freezed == profil_id
          ? _value.profil_id
          : profil_id // ignore: cast_nullable_to_non_nullable
              as String?,
      photo_profil: freezed == photo_profil
          ? _value.photo_profil
          : photo_profil // ignore: cast_nullable_to_non_nullable
              as String?,
      is_active: freezed == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String firstname,
      String lastname,
      String? email,
      String? country_prefix,
      String? company,
      String? telephone,
      String? profil_id,
      String? photo_profil,
      String? is_active});
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? firstname = null,
    Object? lastname = null,
    Object? email = freezed,
    Object? country_prefix = freezed,
    Object? company = freezed,
    Object? telephone = freezed,
    Object? profil_id = freezed,
    Object? photo_profil = freezed,
    Object? is_active = freezed,
  }) {
    return _then(_$AppUserImpl(
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      country_prefix: freezed == country_prefix
          ? _value.country_prefix
          : country_prefix // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      telephone: freezed == telephone
          ? _value.telephone
          : telephone // ignore: cast_nullable_to_non_nullable
              as String?,
      profil_id: freezed == profil_id
          ? _value.profil_id
          : profil_id // ignore: cast_nullable_to_non_nullable
              as String?,
      photo_profil: freezed == photo_profil
          ? _value.photo_profil
          : photo_profil // ignore: cast_nullable_to_non_nullable
              as String?,
      is_active: freezed == is_active
          ? _value.is_active
          : is_active // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl with DiagnosticableTreeMixin implements _AppUser {
  _$AppUserImpl(
      {required this.firstname,
      required this.lastname,
      this.email,
      this.country_prefix,
      this.company,
      this.telephone,
      this.profil_id,
      this.photo_profil,
      this.is_active});

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final String firstname;
  @override
  final String lastname;
  @override
  final String? email;
  @override
  final String? country_prefix;
  @override
  final String? company;
  @override
  final String? telephone;
  @override
  final String? profil_id;
  @override
  final String? photo_profil;
  @override
  final String? is_active;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppUser(firstname: $firstname, lastname: $lastname, email: $email, country_prefix: $country_prefix, company: $company, telephone: $telephone, profil_id: $profil_id, photo_profil: $photo_profil, is_active: $is_active)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppUser'))
      ..add(DiagnosticsProperty('firstname', firstname))
      ..add(DiagnosticsProperty('lastname', lastname))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('country_prefix', country_prefix))
      ..add(DiagnosticsProperty('company', company))
      ..add(DiagnosticsProperty('telephone', telephone))
      ..add(DiagnosticsProperty('profil_id', profil_id))
      ..add(DiagnosticsProperty('photo_profil', photo_profil))
      ..add(DiagnosticsProperty('is_active', is_active));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.country_prefix, country_prefix) ||
                other.country_prefix == country_prefix) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.telephone, telephone) ||
                other.telephone == telephone) &&
            (identical(other.profil_id, profil_id) ||
                other.profil_id == profil_id) &&
            (identical(other.photo_profil, photo_profil) ||
                other.photo_profil == photo_profil) &&
            (identical(other.is_active, is_active) ||
                other.is_active == is_active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, firstname, lastname, email,
      country_prefix, company, telephone, profil_id, photo_profil, is_active);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser implements AppUser {
  factory _AppUser(
      {required final String firstname,
      required final String lastname,
      final String? email,
      final String? country_prefix,
      final String? company,
      final String? telephone,
      final String? profil_id,
      final String? photo_profil,
      final String? is_active}) = _$AppUserImpl;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String get firstname;
  @override
  String get lastname;
  @override
  String? get email;
  @override
  String? get country_prefix;
  @override
  String? get company;
  @override
  String? get telephone;
  @override
  String? get profil_id;
  @override
  String? get photo_profil;
  @override
  String? get is_active;
  @override
  @JsonKey(ignore: true)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
