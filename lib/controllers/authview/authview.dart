import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../views/utils/constantes.dart';
import '../../appservices/apiservices/apireponse.dart';
import '../../appservices/apiservices/dio_implements.dart';
import '../../models/appuser/appuser.dart';
import '../init.dart';

part 'authview.g.dart';
part 'authview.freezed.dart';

@riverpod
class Authview extends _$Authview {
  static const String url_login = "auth/v1/user/login";
  static const String url_register = "auth/v1/user/register";
  static const String url_activation = "auth/v1/user/activation";
  static const String url_ressetPassword = "auth/v1/user/reset";

  @override
  AuthState build() {
    var data = interne_storage.read(user);
    return data != null
        ? AuthState(user: AppUser.fromJson(Map<String, dynamic>.from(data)))
        : const AuthState();
  }

  // ─── LOGIN ─────────────────────────────────────────────────────────────────

  Future<bool> login(String account, String password) async {
    update(loading: true, msg: "Connexion en cours ....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_login,
          payload: {
            "account": account,
            "password": password,
          },
          headers: {
            "Authorization":
                'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
          },
          method: "POST",
        ),
        onPositiveResponse: (response) {
          final AppUser appUser =
              AppUser.fromJson(Map<String, dynamic>.from(response.data[user]));
          interne_storage.write(tokens, response.data[tokens]);
          interne_storage.write(user, response.data[user]);
          update(user: appUser);
        },
      );

      update(
        loading: false,
        success: reponse.status!,
        msg: reponse.message,
      );
      await Future.delayed(const Duration(milliseconds: 500));
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }

  // ─── REGISTER ──────────────────────────────────────────────────────────────

  Future<bool> register({
    required String login,
    required String password,
    required String company,
    required String firstname,
    required String lastname,
    required String email,
    required String country,
    required String telephone,
  }) async {
    update(loading: true, msg: "Inscription en cours ....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_register,
          payload: {
            "login": login,
            "password": password,
            "firstname": firstname,
            "lastname": lastname,
            "email": email,
            "country": country,
            "telephone": telephone,
            "company": company,
          },
          headers: {
            "Authorization":
                'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
          },
          method: "POST",
        ),
        onPositiveResponse: (response) {
          // L'API renvoie {"status":"success","msg":"...","data": <user_id>}
          update(account: response.data["data"]?.toString() ?? "");
        },
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      await Future.delayed(const Duration(milliseconds: 500));
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }

  // ─── ACTIVATION ────────────────────────────────────────────────────────────

  Future<bool> activation({
    required String account,
    required String password,
    required String code,
  }) async {
    update(loading: true, msg: "Activation du compte en cours ....");
    try {
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
          requestEndpoint: url_activation,
          payload: {
            "account": account,
            "password": password,
            "code": code,
          },
          headers: {
            "Authorization":
                'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
          },
          method: "POST",
        ),
        onPositiveResponse: (response) {},
      );
      update(loading: false, success: reponse.status!, msg: reponse.message);
      await Future.delayed(const Duration(milliseconds: 500));
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }

  // ─── LOGOUT ────────────────────────────────────────────────────────────────

  Future<bool> logout() async {
    update(loading: true, msg: "Déconnexion en cours ....");
    try {
      interne_storage.write(user, null);
      interne_storage.write(tokens, null);
      interne_storage.write(portefeuilles, null);
      interne_storage.write(ktes, null);
      interne_storage.write(boutiks, null);
      interne_storage.write(cmpt, null);
      interne_storage.write(souscription, null);
      interne_storage.write(devAccounts, null);

      await Future.delayed(const Duration(milliseconds: 500));
      update(loading: false, success: true, logout: true, msg: "Déconnexion réussie");
      await Future.delayed(const Duration(milliseconds: 510));
      return true;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }

  // ─── UPDATE STATE ──────────────────────────────────────────────────────────

  void update({
    AppUser? user,
    bool? loading,
    bool? success,
    String? msg,
    bool? logout,
    String? account,
  }) {
    state = state.copyWith(
      user: user ?? state.user,
      loading: loading ?? state.loading,
      succes: success ?? state.succes,
      message: msg ?? state.message,
      logout: logout ?? state.logout,
      account: account ?? state.account,
    );
  }
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    AppUser? user,
    @Default(false) bool loading,
    @Default(false) bool succes,
    @Default(false) bool logout,
    @Default('') String account,
    @Default('Opération en cours ...') String message,
  }) = _AuthState;
}
