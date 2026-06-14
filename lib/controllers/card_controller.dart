import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../views/utils/constantes.dart';
import '../appservices/apiservices/apireponse.dart';
import '../appservices/apiservices/dio_implements.dart';
import '../models/card/card_model.dart';
import 'init.dart';

part 'card_controller.g.dart';
part 'card_controller.freezed.dart';

@riverpod
class CardController extends _$CardController {
  // ─── URLs (corrigées d'après Postman) ──────────────────────────────────────
  static const String url_create               = "v1/card/create";
  static const String url_load                 = "v1/card/load";
  static const String url_withdrawal_init      = "v1/card/withdrawalInit";
  static const String url_withdrawal_validate  = "v1/card/withdrawalSet";
  static const String url_transfer_init        = "v1/card/TransferToCardInit";
  static const String url_transfer_validate    = "v1/card/TransferToCardSet";
  static const String url_transactions         = "v1/card/TransactionsList";
  static const String url_infos                = "v1/card/infos";
  static const String url_pci                  = "v1/card/cardPCIData";
  static const String url_balance              = "v1/card/balance";
  static const String url_activate             = "v1/card/activation";
  static const String url_deactivate           = "v1/card/desactivation";

  @override
  CardState build() => const CardState();

  String get _token => interne_storage.read(tokens) ?? '';

  Map<String, String> get _authHeaders => {
    "Authorization":
        'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
  };

  // ─── CREATE CARD ───────────────────────────────────────────────────────────

  Future<bool> createCard({
    required String civility,
    required String lastname,
    required String firstname,
    required String email,
    required String telephone,
    required String nationality,
    required String birthday,
    required String birthplace,
    required String address,
    required String city,
    required String countryCode,
    required String profession,
    required String identityNumber,
    required String typePiece,
    required String dateDelivery,
    required String dateExpiry,
    required String placeEstablishment,
    required String dateExpirationInMonths,
    required String sender,
    File? photo,
    File? piece,
  }) async {
    update(loading: true, msg: "Création de la carte en cours....");
    try {
      final formData = FormData.fromMap({
        "token": _token,
        "civility": civility,
        "lastname": lastname,
        "firstname": firstname,
        "email": email,
        "telephone": telephone,
        "nationality": nationality,
        "birthday": birthday,
        "birthplace": birthplace,
        "address": address,
        "city": city,
        "country_code": countryCode,
        "profession": profession,
        "identity_number": identityNumber,
        "type_piece": typePiece,
        "date_delivery": dateDelivery,
        "date_expiry": dateExpiry,
        "place_establishment_doc": placeEstablishment,
        "date_expiration_in_months": dateExpirationInMonths,
        "sender": sender,
        if (photo != null)
          "photo": await MultipartFile.fromFile(photo.path, filename: "photo.jpg"),
        if (piece != null)
          "piece": await MultipartFile.fromFile(piece.path, filename: "piece.jpg"),
      });

      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_create,
          payload: formData,
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          // Retourne l'id de la carte créée : {"status":"success","msg":"...","data": <id>}
          update(createdCardId: response.data["data"]?.toString() ?? "");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      await Future.delayed(const Duration(milliseconds: 300));
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la création de la carte");
      return false;
    }
  }

  // ─── LOAD CARD (Recharge) ──────────────────────────────────────────────────

  Future<bool> loadCard({
    required String carteId,
    required String amount,
    required String last4Digits,
    required String phone,
    required String appKey,
  }) async {
    update(loading: true, msg: "Recharge de la carte en cours....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_load,
          payload: {
            "carteId": carteId,
            "amount": amount,
            "last4Digits": last4Digits,
            "phone": phone,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {},
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      await Future.delayed(const Duration(milliseconds: 300));
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la recharge");
      return false;
    }
  }

  // ─── WITHDRAWAL INIT ───────────────────────────────────────────────────────

  Future<String?> withdrawalInit({
    required String carteId,
    required String amount,
    required String last4Digits,
    required String phone,
    required String appKey,
  }) async {
    update(loading: true, msg: "Initiation du retrait en cours....");
    try {
      String? withdrawalId;
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_withdrawal_init,
          payload: {
            "carteId": carteId,
            "amount": amount,
            "last4Digits": last4Digits,
            "phone": phone,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          // Retourne : {"status":"success","msg":"...","id": <id>}
          withdrawalId = response.data["id"]?.toString();
          update(pendingWithdrawalId: withdrawalId ?? "");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      await Future.delayed(const Duration(milliseconds: 300));
      return reponse.status! ? withdrawalId : null;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de l'initiation du retrait");
      return null;
    }
  }

  // ─── WITHDRAWAL VALIDATE ───────────────────────────────────────────────────

  Future<bool> withdrawalValidate({
    required String withdrawalId,
    required String code,
    required String appKey,
  }) async {
    update(loading: true, msg: "Validation du retrait en cours....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_withdrawal_validate,
          payload: {
            "id": withdrawalId,
            "code": code,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          update(pendingWithdrawalId: "");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la validation du retrait");
      return false;
    }
  }

  // ─── TRANSFER TO CARD INIT ─────────────────────────────────────────────────
  // POST /v1/card/TransferToCardInit
  // Body: fromCarteId, amount, last4Digits, toCarteId, app_key
  // Response: {"status":"success","msg":"Transfert initié avec succes.","id": 17}

  Future<String?> transferInit({
    required String fromCarteId,
    required String toCarteId,
    required String amount,
    required String last4Digits,
    required String appKey,
  }) async {
    update(loading: true, msg: "Initiation du transfert en cours....");
    try {
      String? transferId;
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_transfer_init,
          payload: {
            "fromCarteId": fromCarteId,
            "toCarteId": toCarteId,
            "amount": amount,
            "last4Digits": last4Digits,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          transferId = response.data["id"]?.toString();
          update(pendingTransferId: transferId ?? "");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status! ? transferId : null;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de l'initiation du transfert");
      return null;
    }
  }

  // ─── TRANSFER VALIDATE ─────────────────────────────────────────────────────

  Future<bool> transferValidate({
    required String transferId,
    required String code,
    required String appKey,
  }) async {
    update(loading: true, msg: "Validation du transfert en cours....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_transfer_validate,
          payload: {
            "id": transferId,
            "code": code,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          update(pendingTransferId: "");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la validation du transfert");
      return false;
    }
  }

  // ─── GET ALL TRANSACTIONS ──────────────────────────────────────────────────
  // POST /v1/card/TransactionsList
  // Body: carteId, date (format: MM-YYYY), app_key
  // Response: {"status":"success","msg":"...","data": [{ transactionId, transactionDate,
  //   base, currency, baseAmount, fee, totalAmount, balance, carteCreditId,
  //   carteDebitId, accountId, partnerId, status, carteId, operation, description }]}

  Future<bool> fetchTransactions({
    required String carteId,
    required String date, // format: MM-YYYY (ex: 05-2026)
    required String appKey,
  }) async {
    update(loading: true, msg: "Chargement des transactions....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_transactions,
          payload: {
            "carteId": carteId,
            "date": date,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          final rawList = response.data["data"];
          if (rawList is List) {
            final txs = rawList
                .map((e) => CardTransaction.fromJson(Map<String, dynamic>.from(e)))
                .toList();
            update(transactions: txs);
          }
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors du chargement des transactions");
      return false;
    }
  }

  // ─── CARD INFOS ────────────────────────────────────────────────────────────
  // POST /v1/card/infos
  // Body: carteId, app_key  (pas de token !)
  // Response: {"status":"success","msg":"...","data": [{ civility, lastname, firstname,
  //   email, phone, nationality, birthday, birthplace, address, city, profession,
  //   carteExpiryDate, statusCarte, accountId }]}
  // Note: data est un TABLEAU même si un seul élément

  Future<bool> fetchCardInfos({
    required String carteId,
    required String appKey,
  }) async {
    update(loading: true, msg: "Chargement des infos de la carte....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_infos,
          payload: {
            "carteId": carteId,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          final rawData = response.data["data"];
          if (rawData is Map) {
            final info = CardInfo.fromJson(Map<String, dynamic>.from(rawData));
            update(currentCardInfo: info);
          }
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors du chargement des infos");
      return false;
    }
  }

  // ─── GET ALL CARDS ─────────────────────────────────────────────────────────

  Future<bool> fetchCardsList({
    required String appKey,
  }) async {
    update(loading: true, msg: "Chargement de vos cartes....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_infos, // Assuming infos returns all if carteId is empty
          payload: {
            "carteId": "",
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          final rawList = response.data["data"];
          if (rawList is List) {
            final cards = rawList
                .map((e) => CardInfo.fromJson(Map<String, dynamic>.from(e)))
                .toList();
            update(cards: cards);
          }
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors du chargement de la liste des cartes");
      return false;
    }
  }

  // ─── CARD PCI DATA ─────────────────────────────────────────────────────────
  // Response: {"status":"success","msg":"URL pci-info généré","url":"https://..."}
  // Retourne une URL sécurisée à ouvrir dans un WebView ou url_launcher

  Future<String?> fetchCardPciUrl({
    required String carteId,
    required String appKey,
  }) async {
    update(loading: true, msg: "Génération du lien PCI en cours....");
    try {
      String? pciUrl;
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_pci,
          payload: {
            "carteId": carteId,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          pciUrl = response.data["url"]?.toString();
          update(pciUrl: pciUrl ?? "");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status! ? pciUrl : null;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la génération PCI");
      return null;
    }
  }

  // ─── CARD BALANCE ──────────────────────────────────────────────────────────

  Future<String?> fetchBalance({
    required String carteId,
    required String appKey,
  }) async {
    update(loading: true, msg: "Consultation du solde....");
    try {
      String? balance;
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_balance,
          payload: {
            "carteId": carteId,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {
          balance = response.data["data"]?.toString();
          update(cardBalance: balance ?? "0");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status! ? balance : null;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la consultation du solde");
      return null;
    }
  }

  // ─── CARD ACTIVATION ───────────────────────────────────────────────────────
  // POST /v1/card/activation
  // Body: carteId, app_key

  Future<bool> activateCard({
    required String carteId,
    required String appKey,
  }) async {
    update(loading: true, msg: "Activation de la carte en cours....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_activate,
          payload: {
            "carteId": carteId,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {},
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de l'activation");
      return false;
    }
  }

  // ─── CARD DESACTIVATION ────────────────────────────────────────────────────
  // POST /v1/card/desactivation
  // Body: carteId, app_key

  Future<bool> deactivateCard({
    required String carteId,
    required String appKey,
  }) async {
    update(loading: true, msg: "Désactivation de la carte en cours....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_deactivate,
          payload: {
            "carteId": carteId,
            "app_key": appKey,
          },
          headers: _authHeaders,
          method: "POST",
        ),
        onPositiveResponse: (response) {},
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la désactivation");
      return false;
    }
  }

  // ─── UPDATE STATE ──────────────────────────────────────────────────────────

  void update({
    bool? loading,
    bool? success,
    String? msg,
    CardInfo? currentCardInfo,
    List<CardTransaction>? transactions,
    String? pciUrl,
    String? cardBalance,
    String? createdCardId,
    String? pendingWithdrawalId,
    String? pendingTransferId,
    List<CardInfo>? cards,
  }) {
    state = state.copyWith(
      loading: loading ?? state.loading,
      succes: success ?? state.succes,
      message: msg ?? state.message,
      currentCardInfo: currentCardInfo ?? state.currentCardInfo,
      transactions: transactions ?? state.transactions,
      pciUrl: pciUrl ?? state.pciUrl,
      cardBalance: cardBalance ?? state.cardBalance,
      createdCardId: createdCardId ?? state.createdCardId,
      pendingWithdrawalId: pendingWithdrawalId ?? state.pendingWithdrawalId,
      pendingTransferId: pendingTransferId ?? state.pendingTransferId,
      cards: cards ?? state.cards,
    );
  }
}

// ─── STATE ─────────────────────────────────────────────────────────────────────

@freezed
class CardState with _$CardState {
  const factory CardState({
    @Default(false) bool loading,
    @Default(false) bool succes,
    @Default('') String message,
    CardInfo? currentCardInfo,
    @Default([]) List<CardTransaction> transactions,
    @Default('') String pciUrl,
    @Default('0') String cardBalance,
    @Default('') String createdCardId,
    @Default('') String pendingWithdrawalId,
    @Default('') String pendingTransferId,
    @Default([]) List<CardInfo> cards,
  }) = _CardState;
}
