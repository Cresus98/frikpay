// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_account_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DevAccountState {
  List<DevAccount> get accounts => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get succes => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DevAccountStateCopyWith<DevAccountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevAccountStateCopyWith<$Res> {
  factory $DevAccountStateCopyWith(
          DevAccountState value, $Res Function(DevAccountState) then) =
      _$DevAccountStateCopyWithImpl<$Res, DevAccountState>;
  @useResult
  $Res call(
      {List<DevAccount> accounts, bool loading, bool succes, String message});
}

/// @nodoc
class _$DevAccountStateCopyWithImpl<$Res, $Val extends DevAccountState>
    implements $DevAccountStateCopyWith<$Res> {
  _$DevAccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? loading = null,
    Object? succes = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      accounts: null == accounts
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<DevAccount>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      succes: null == succes
          ? _value.succes
          : succes // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevAccountStateImplCopyWith<$Res>
    implements $DevAccountStateCopyWith<$Res> {
  factory _$$DevAccountStateImplCopyWith(_$DevAccountStateImpl value,
          $Res Function(_$DevAccountStateImpl) then) =
      __$$DevAccountStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DevAccount> accounts, bool loading, bool succes, String message});
}

/// @nodoc
class __$$DevAccountStateImplCopyWithImpl<$Res>
    extends _$DevAccountStateCopyWithImpl<$Res, _$DevAccountStateImpl>
    implements _$$DevAccountStateImplCopyWith<$Res> {
  __$$DevAccountStateImplCopyWithImpl(
      _$DevAccountStateImpl _value, $Res Function(_$DevAccountStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? loading = null,
    Object? succes = null,
    Object? message = null,
  }) {
    return _then(_$DevAccountStateImpl(
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<DevAccount>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      succes: null == succes
          ? _value.succes
          : succes // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DevAccountStateImpl implements _DevAccountState {
  const _$DevAccountStateImpl(
      {final List<DevAccount> accounts = const [],
      this.loading = false,
      this.succes = false,
      this.message = ''})
      : _accounts = accounts;

  final List<DevAccount> _accounts;
  @override
  @JsonKey()
  List<DevAccount> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool succes;
  @override
  @JsonKey()
  final String message;

  @override
  String toString() {
    return 'DevAccountState(accounts: $accounts, loading: $loading, succes: $succes, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevAccountStateImpl &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.succes, succes) || other.succes == succes) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_accounts), loading, succes, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DevAccountStateImplCopyWith<_$DevAccountStateImpl> get copyWith =>
      __$$DevAccountStateImplCopyWithImpl<_$DevAccountStateImpl>(
          this, _$identity);
}

abstract class _DevAccountState implements DevAccountState {
  const factory _DevAccountState(
      {final List<DevAccount> accounts,
      final bool loading,
      final bool succes,
      final String message}) = _$DevAccountStateImpl;

  @override
  List<DevAccount> get accounts;
  @override
  bool get loading;
  @override
  bool get succes;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$DevAccountStateImplCopyWith<_$DevAccountStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
