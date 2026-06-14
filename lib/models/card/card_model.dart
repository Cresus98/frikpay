import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'card_model.freezed.dart';
part 'card_model.g.dart';

/// Données d'une carte renvoyées par Card Infos (/v1/card/infos)
@freezed
class CardInfo with _$CardInfo {
  const factory CardInfo({
    @Default('') String civility,
    @Default('') String firstname,
    @Default('') String lastname,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String nationality,
    @Default('') String birthday,
    @Default('') String birthplace,
    @Default('') String address,
    @Default('') String city,
    @Default('') String profession,
    @Default('') String carteExpiryDate,
    @Default('') String statusCarte,
    @Default('') String accountId,
  }) = _CardInfo;

  factory CardInfo.fromJson(Map<String, dynamic> json) =>
      _$CardInfoFromJson(json);
}

/// Une transaction de carte (renvoyée par /v1/card/TransactionsList)
@freezed
class CardTransaction with _$CardTransaction {
  const factory CardTransaction({
    @Default('') String transactionId,
    @Default('') String transactionDate,
    @Default('') String base,
    @Default('') String currency,
    @Default('') String baseAmount,
    @Default('') String fee,
    @Default('') String totalAmount,
    @Default('') String balance,
    @Default('') String carteCreditId,
    @Default('') String carteDebitId,
    @Default('') String accountId,
    @Default('') String partnerId,
    @Default('') String status,
    @Default('') String carteId,
    @Default('') String operation,
    @Default('') String description,
  }) = _CardTransaction;

  factory CardTransaction.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionFromJson(json);
}

/// Réponse du Card PCI Data (/v1/card/pci) — retourne une URL sécurisée
@freezed
class CardPciResponse with _$CardPciResponse {
  const factory CardPciResponse({
    @Default('') String url,
    @Default('') String msg,
  }) = _CardPciResponse;

  factory CardPciResponse.fromJson(Map<String, dynamic> json) =>
      _$CardPciResponseFromJson(json);
}
