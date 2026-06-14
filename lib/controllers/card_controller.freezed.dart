// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CardState {
  bool get loading => throw _privateConstructorUsedError;
  bool get succes => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  CardInfo? get currentCardInfo => throw _privateConstructorUsedError;
  List<CardTransaction> get transactions => throw _privateConstructorUsedError;
  String get pciUrl => throw _privateConstructorUsedError;
  String get cardBalance => throw _privateConstructorUsedError;
  String get createdCardId => throw _privateConstructorUsedError;
  String get pendingWithdrawalId => throw _privateConstructorUsedError;
  String get pendingTransferId => throw _privateConstructorUsedError;
  List<CardInfo> get cards => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardStateCopyWith<CardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardStateCopyWith<$Res> {
  factory $CardStateCopyWith(CardState value, $Res Function(CardState) then) =
      _$CardStateCopyWithImpl<$Res, CardState>;
  @useResult
  $Res call(
      {bool loading,
      bool succes,
      String message,
      CardInfo? currentCardInfo,
      List<CardTransaction> transactions,
      String pciUrl,
      String cardBalance,
      String createdCardId,
      String pendingWithdrawalId,
      String pendingTransferId,
      List<CardInfo> cards});

  $CardInfoCopyWith<$Res>? get currentCardInfo;
}

/// @nodoc
class _$CardStateCopyWithImpl<$Res, $Val extends CardState>
    implements $CardStateCopyWith<$Res> {
  _$CardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? succes = null,
    Object? message = null,
    Object? currentCardInfo = freezed,
    Object? transactions = null,
    Object? pciUrl = null,
    Object? cardBalance = null,
    Object? createdCardId = null,
    Object? pendingWithdrawalId = null,
    Object? pendingTransferId = null,
    Object? cards = null,
  }) {
    return _then(_value.copyWith(
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
      currentCardInfo: freezed == currentCardInfo
          ? _value.currentCardInfo
          : currentCardInfo // ignore: cast_nullable_to_non_nullable
              as CardInfo?,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<CardTransaction>,
      pciUrl: null == pciUrl
          ? _value.pciUrl
          : pciUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardBalance: null == cardBalance
          ? _value.cardBalance
          : cardBalance // ignore: cast_nullable_to_non_nullable
              as String,
      createdCardId: null == createdCardId
          ? _value.createdCardId
          : createdCardId // ignore: cast_nullable_to_non_nullable
              as String,
      pendingWithdrawalId: null == pendingWithdrawalId
          ? _value.pendingWithdrawalId
          : pendingWithdrawalId // ignore: cast_nullable_to_non_nullable
              as String,
      pendingTransferId: null == pendingTransferId
          ? _value.pendingTransferId
          : pendingTransferId // ignore: cast_nullable_to_non_nullable
              as String,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardInfo>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CardInfoCopyWith<$Res>? get currentCardInfo {
    if (_value.currentCardInfo == null) {
      return null;
    }

    return $CardInfoCopyWith<$Res>(_value.currentCardInfo!, (value) {
      return _then(_value.copyWith(currentCardInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CardStateImplCopyWith<$Res>
    implements $CardStateCopyWith<$Res> {
  factory _$$CardStateImplCopyWith(
          _$CardStateImpl value, $Res Function(_$CardStateImpl) then) =
      __$$CardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool loading,
      bool succes,
      String message,
      CardInfo? currentCardInfo,
      List<CardTransaction> transactions,
      String pciUrl,
      String cardBalance,
      String createdCardId,
      String pendingWithdrawalId,
      String pendingTransferId,
      List<CardInfo> cards});

  @override
  $CardInfoCopyWith<$Res>? get currentCardInfo;
}

/// @nodoc
class __$$CardStateImplCopyWithImpl<$Res>
    extends _$CardStateCopyWithImpl<$Res, _$CardStateImpl>
    implements _$$CardStateImplCopyWith<$Res> {
  __$$CardStateImplCopyWithImpl(
      _$CardStateImpl _value, $Res Function(_$CardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
    Object? succes = null,
    Object? message = null,
    Object? currentCardInfo = freezed,
    Object? transactions = null,
    Object? pciUrl = null,
    Object? cardBalance = null,
    Object? createdCardId = null,
    Object? pendingWithdrawalId = null,
    Object? pendingTransferId = null,
    Object? cards = null,
  }) {
    return _then(_$CardStateImpl(
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
      currentCardInfo: freezed == currentCardInfo
          ? _value.currentCardInfo
          : currentCardInfo // ignore: cast_nullable_to_non_nullable
              as CardInfo?,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<CardTransaction>,
      pciUrl: null == pciUrl
          ? _value.pciUrl
          : pciUrl // ignore: cast_nullable_to_non_nullable
              as String,
      cardBalance: null == cardBalance
          ? _value.cardBalance
          : cardBalance // ignore: cast_nullable_to_non_nullable
              as String,
      createdCardId: null == createdCardId
          ? _value.createdCardId
          : createdCardId // ignore: cast_nullable_to_non_nullable
              as String,
      pendingWithdrawalId: null == pendingWithdrawalId
          ? _value.pendingWithdrawalId
          : pendingWithdrawalId // ignore: cast_nullable_to_non_nullable
              as String,
      pendingTransferId: null == pendingTransferId
          ? _value.pendingTransferId
          : pendingTransferId // ignore: cast_nullable_to_non_nullable
              as String,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardInfo>,
    ));
  }
}

/// @nodoc

class _$CardStateImpl implements _CardState {
  const _$CardStateImpl(
      {this.loading = false,
      this.succes = false,
      this.message = '',
      this.currentCardInfo,
      final List<CardTransaction> transactions = const [],
      this.pciUrl = '',
      this.cardBalance = '0',
      this.createdCardId = '',
      this.pendingWithdrawalId = '',
      this.pendingTransferId = '',
      final List<CardInfo> cards = const []})
      : _transactions = transactions,
        _cards = cards;

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
  final CardInfo? currentCardInfo;
  final List<CardTransaction> _transactions;
  @override
  @JsonKey()
  List<CardTransaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  @JsonKey()
  final String pciUrl;
  @override
  @JsonKey()
  final String cardBalance;
  @override
  @JsonKey()
  final String createdCardId;
  @override
  @JsonKey()
  final String pendingWithdrawalId;
  @override
  @JsonKey()
  final String pendingTransferId;
  final List<CardInfo> _cards;
  @override
  @JsonKey()
  List<CardInfo> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'CardState(loading: $loading, succes: $succes, message: $message, currentCardInfo: $currentCardInfo, transactions: $transactions, pciUrl: $pciUrl, cardBalance: $cardBalance, createdCardId: $createdCardId, pendingWithdrawalId: $pendingWithdrawalId, pendingTransferId: $pendingTransferId, cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardStateImpl &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.succes, succes) || other.succes == succes) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentCardInfo, currentCardInfo) ||
                other.currentCardInfo == currentCardInfo) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.pciUrl, pciUrl) || other.pciUrl == pciUrl) &&
            (identical(other.cardBalance, cardBalance) ||
                other.cardBalance == cardBalance) &&
            (identical(other.createdCardId, createdCardId) ||
                other.createdCardId == createdCardId) &&
            (identical(other.pendingWithdrawalId, pendingWithdrawalId) ||
                other.pendingWithdrawalId == pendingWithdrawalId) &&
            (identical(other.pendingTransferId, pendingTransferId) ||
                other.pendingTransferId == pendingTransferId) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loading,
      succes,
      message,
      currentCardInfo,
      const DeepCollectionEquality().hash(_transactions),
      pciUrl,
      cardBalance,
      createdCardId,
      pendingWithdrawalId,
      pendingTransferId,
      const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardStateImplCopyWith<_$CardStateImpl> get copyWith =>
      __$$CardStateImplCopyWithImpl<_$CardStateImpl>(this, _$identity);
}

abstract class _CardState implements CardState {
  const factory _CardState(
      {final bool loading,
      final bool succes,
      final String message,
      final CardInfo? currentCardInfo,
      final List<CardTransaction> transactions,
      final String pciUrl,
      final String cardBalance,
      final String createdCardId,
      final String pendingWithdrawalId,
      final String pendingTransferId,
      final List<CardInfo> cards}) = _$CardStateImpl;

  @override
  bool get loading;
  @override
  bool get succes;
  @override
  String get message;
  @override
  CardInfo? get currentCardInfo;
  @override
  List<CardTransaction> get transactions;
  @override
  String get pciUrl;
  @override
  String get cardBalance;
  @override
  String get createdCardId;
  @override
  String get pendingWithdrawalId;
  @override
  String get pendingTransferId;
  @override
  List<CardInfo> get cards;
  @override
  @JsonKey(ignore: true)
  _$$CardStateImplCopyWith<_$CardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
