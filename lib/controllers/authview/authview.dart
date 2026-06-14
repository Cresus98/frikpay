import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../views/utils/constantes.dart';
import '../../appservices/apiservices/apireponse.dart';
import '../../appservices/apiservices/dio_implements.dart';
import '../../models/appuser/appuser.dart';
import '../../views/utils/fonctions.dart';
import '../init.dart';

part 'authview.g.dart';
part 'authview.freezed.dart';

@Riverpod(keepAlive: true)

class Authview extends _$Authview {
  static String url_login = "auth/v1/user/login";
  static String url_register = "auth/v1/user/register";
  static String url_activation = "auth/v1/user/activation";
  static String url_ressetPassword = "auth/v1/user/reset";
  static String url_add_subscription = "v1/subscription/add";
  static String url_types_subscription = "v1/subscription/types";
  static String url_getCountries = "v1/geography/countries";
  static DioServices dioServices=DioServices(baseUrl: frikpayBaseUrl);
  bool loading = false;


  @override
  AuthState build() {
    var data = interne_storage.read(user);
    return data != null
        ? AuthState(
            user: AppUser.fromJson(data),
          )
        : AuthState(user: AppUser(firstname: "", lastname: ""));
  }

  Future<bool> login({ required String account,  required String password}) async {

//username
  //admin
    //WgF07YevswkZ3UvM

    update(loading: true);
    update(msg: "Connexion en cours ....");
    try {

      ApiReponse reponse=(await dioServices.dispatch(httpRequest:dioServices.request(
            requestEndpoint: url_login,
            payload: {
              "account": account,
              "password": password,
            },
            headers: {
              "Authorization":
              'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
            },
            method: "POST"),
        onPositiveResponse: (response) {
          AppUser appUser=AppUser.fromJson(response.data[user]);
          interne_storage.write(tokens,response.data[tokens]);
          interne_storage.write(user,appUser);
          update(user: appUser);
          print("la réponse du login est donc ${response.data}");
          },
      ));


      update(loading: false, success: reponse.status!,msg: reponse.message);
      await Future.delayed( Duration(milliseconds: reponse.status! ? 1000:3000));

      print("le status final du login est  est ${reponse.status!} de data ${reponse.data}");

      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }

  Future<bool> register({required String login,  required String telephone,required String country, required String firstname,required String lastname, required String company,required String email,}) async {

    /*
     "account": "96312179",
    "password": "25801",
    "profil": "7",
    "module": "6"
     */

    update(loading: true);
    update(msg: "Inscription en cours ....");
    try {
      //await Future.delayed(const Duration(milliseconds: 5000));
      ApiReponse reponse=(await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
            requestEndpoint: url_register,
            payload: {
              "login":login,
             // "password":password,
              "telephone": telephone,
              "country":country,
              "firstname": firstname,
              "lastname": lastname,
              "company":company,
              "email": email,
            },
            headers: {
              //"X-API-KEY": header_code,
              "Authorization": 'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
              //'Content-Type': 'application/json'
            },
            method: "POST"),
        onPositiveResponse: (response) {

          update(account: login);
          print("la réponse du register  est donc ${response.data}");
          },
      ));
      update(loading: false, success: reponse.status!);

      update(msg:reponse.message );
      if(reponse.status!)
      {
      }
      await Future.delayed(const Duration(milliseconds: 500));
      print("le status final est ${reponse.status!}");

      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }


  Future<bool> activation_compte({required String code,required String password}) async {
    update(loading: true);
    update(msg: "Activation du compte  en cours ....");

    try {


      ApiReponse reponse= await dioServices.dispatch(
          httpRequest: dioServices.request(
              requestEndpoint: url_activation,
              headers: {
                "Authorization": 'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
              },
              payload: {
                "code": code,
                "account": state.account,
                "password": password
              },
              method: 'POST'));

      update(loading: false, success: reponse.status!);
      update(msg:reponse.message );
      await Future.delayed(const Duration(milliseconds: 500));
      print("le status final de l'activation  est ${reponse.status!}");
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }

  Future<bool> logout() async {
    update(loading: true);
    update(msg: "Déconnexion en cours ....");

    try {

      interne_storage.write(user,null);
      interne_storage.write(tokens,null);



      //ref.invalidate(gettinCurrencyProvider);
      //ref.invalidate(gettinWalletProvider);

      await Future.delayed(const Duration(milliseconds: 1000));
      update(loading: false, success: true,logout: true);
      update(msg:"Déconnexion réussie ");
      await Future.delayed(const Duration(milliseconds: 510));
      return true;
    } catch (e) {
      update(loading: true, success: false);
      return false;
    }
  }


/*
  Future<bool> ressetPassword({required String lang,required String account}) async {
    update(loading: true);
    update(msg: "Envoie du code pour réinitialisation  du mot de passe en cours ....");
    try {
      var data = {
        "account": account,
        "lang": lang
      };

      FormData formData=FormData.fromMap(data);
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
          httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
              requestEndpoint: url_ressetPassword,
              payload: formData,
              headers: {
                "X-API-KEY": header_code,
                "Authorization": 'Basic ${base64Encode(utf8.encode('$bearer_username_reset:$bearer_password'))}',
              },
              method: 'POST',
            rcase: RequestCase.ResetSendCodeLong
          ),
      onPositiveResponse: (rep){
            update(account: rep.data["account"]);
      } ,);
      update(loading: false, success: reponse.status!);
      update(msg:reponse.message );
      await Future.delayed(const Duration(milliseconds: 500));
      print("le status final  de la reinitialisation 1 est ${reponse.status!}");
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }

  Future<bool> validateResset({required String code,required String account, required String password}) async {
    update(loading: true);
    update(msg: "Reinitialisation du mot de passe en cours ....");
    try {
      //CLTFF240004932
      var data = {
        "account": state.account,
        "code": code,
        "password":password,
        "lang":"fr"
      };
      FormData formData=FormData.fromMap(data);
      ApiReponse reponse = await DioServices.withoutNothing().dispatch(
          httpRequest: DioServices(baseUrl: clientAuthBaseUrl).request(
              requestEndpoint: url_activation,
              payload: formData,
              headers: {
                "X-API-KEY": header_code,
                "Authorization": 'Basic ${base64Encode(utf8.encode('$bearer_username_reset:$bearer_password'))}',
              },
              method: 'POST',
          rcase: RequestCase.ResetWithMessageResetFormat),
      onPositiveResponse: (rep){
      } ,);
      update(loading: false, success: reponse.status!);

      if(reponse.status!){
        update(msg: "Reinitilisation du mot de passe réussie!");
      }
      else{
        update(msg: "Mot de passe trop faible ");
      }
      await Future.delayed(const Duration(milliseconds: 500));
      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }


  Future<bool> activation({String ? email, required String lang, required String code, required String account, required String password}) async {
    update(loading: true);
    update(msg: "Activation du compte  en cours ....");

    try {

      var data = {
        "code":code,
        "account":account,
        "password":password,
        "lang":lang};
      if (email != null) {
        data["email"] = email;
      }
      FormData formData=FormData.fromMap(data);
      ApiReponse reponse= await DioServices.withoutNothing().dispatch(
          httpRequest: DioServices(baseUrl: clientAuthBaseUrl).request(
              requestEndpoint: url_activation,
              payload: formData,
              params: {"account":account,
              "password":password},
              method: 'POST'));

      update(loading: false, success: reponse.status!);
      update(msg:reponse.message );
      await Future.delayed(const Duration(milliseconds: 500));
      print("le status final de l'activation  est ${reponse.status!}");

      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }


*/

  void update({
    AppUser? user, bool? loading, bool? success,
    String? msg,bool ? logout,String ? account})
  {
    state = state.copyWith(user: user ?? state.user,
        loading: loading ?? state.loading, succes: success ?? state.succes,
        message: msg ?? state.message,
    logout:logout??state.logout,
        account:account??state.account,
    );
  }
}




@freezed
class AuthState with _$AuthState {
  factory AuthState({
    AppUser? user,
    @Default(false) bool loading,
    @Default(false) bool succes,
    @Default(false) bool logout,
    @Default("") String account,
    @Default('Opération en cours ...') String message,
  }) = _AuthState;
}


