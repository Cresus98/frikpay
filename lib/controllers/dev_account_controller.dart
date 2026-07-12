import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../config/api_config.dart';
import '../appservices/apiservices/apireponse.dart';
import '../appservices/apiservices/dio_implements.dart';
import '../models/dev_account/dev_account.dart';
import 'init.dart';
import '../views/utils/constantes.dart';

part 'dev_account_controller.g.dart';
part 'dev_account_controller.freezed.dart';

@riverpod
class DevAccountController extends _$DevAccountController {

  @override
  DevAccountState build() {
    return const DevAccountState();
  }

  String get _token => interne_storage.read(tokens) ?? '';

  // ─── LIST COMPTES DEV ──────────────────────────────────────────────────────

  Future<bool> fetchAccounts() async {
    update(loading: true, msg: "Chargement des comptes en cours ....");
    try {
      ApiReponse reponse = await DioServices(baseUrl: ApiConfig.baseUrl).dispatch(
        httpRequest: DioServices(baseUrl: ApiConfig.baseUrl).request(
          requestEndpoint: ApiConfig.accountList,
          payload: {
            "token": _token,
          },
          headers: {
            "Authorization":
                ApiConfig.basicAuthHeader,
          },
          method: "POST",
        ),
        onPositiveResponse: (response) {
          // L'API renvoie une liste d'objets comptes
          final rawList = response.data["data"];
          if (rawList is List) {
            final accounts = rawList
                .map((e) => DevAccount.fromJson(Map<String, dynamic>.from(e)))
                .toList();
            update(accounts: accounts);
          }
        },
      );
      update(loading: false, success: reponse.status, msg: reponse.message);
      await Future.delayed(const Duration(milliseconds: 300));
      return reponse.status;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors du chargement");
      return false;
    }
  }

  // ─── ADD COMPTE DEV ────────────────────────────────────────────────────────

  Future<bool> addAccount({required String name}) async {
    update(loading: true, msg: "Création du compte en cours ....");
    try {
      ApiReponse reponse = await DioServices(baseUrl: ApiConfig.baseUrl).dispatch(
        httpRequest: DioServices(baseUrl: ApiConfig.baseUrl).request(
          requestEndpoint: ApiConfig.accountAdd,
          payload: {
            "token": _token,
            "name": name,
          },
          headers: {
            "Authorization":
                ApiConfig.basicAuthHeader,
          },
          method: "POST",
        ),
        onPositiveResponse: (response) async {
          // Recharger la liste après ajout réussi
          await fetchAccounts();
        },
      );
      update(loading: false, success: reponse.status, msg: reponse.message);
      await Future.delayed(const Duration(milliseconds: 300));
      return reponse.status;
    } catch (e) {
      update(loading: false, success: false, msg: "Erreur lors de la création");
      return false;
    }
  }

  // ─── UPDATE STATE ──────────────────────────────────────────────────────────

  void update({
    List<DevAccount>? accounts,
    bool? loading,
    bool? success,
    String? msg,
  }) {
    state = state.copyWith(
      accounts: accounts ?? state.accounts,
      loading: loading ?? state.loading,
      succes: success ?? state.succes,
      message: msg ?? state.message,
    );
  }
}

@freezed
class DevAccountState with _$DevAccountState {
  const factory DevAccountState({
    @Default([]) List<DevAccount> accounts,
    @Default(false) bool loading,
    @Default(false) bool succes,
    @Default('') String message,
  }) = _DevAccountState;
}
