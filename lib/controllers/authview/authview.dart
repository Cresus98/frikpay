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
  static String url_login = "auth/v1/user/login";
  static String url_register = "v1/user/register";
  static String url_activation = "v1/user/activation";
  static String url_ressetPassword = "v1/user/reset";
  static String url_add_subscription = "v1/subscription/add";
  static String url_types_subscription = "v1/subscription/types";
  static String url_getCountries = "v1/geography/countries";
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

  Future<bool> login(String tel, String password, String profil, String module) async {

//username
  //admin
    //WgF07YevswkZ3UvM

    update(loading: true);
    update(msg: "Connexion en cours ....");
    try {
      //await Future.delayed(const Duration(milliseconds: 5000));
      ApiReponse reponse=(await DioServices.withoutNothing().dispatch(
        httpRequest: DioServices(baseUrl: frikpayBaseUrl).request(
            requestEndpoint: url_login,
            payload: {
              "account": tel,
              "password": password,
            },
            headers: {
             //"X-API-KEY": header_code,
              "Authorization":
              'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
              // 'Content-Type': 'application/json'
            },
            method: "POST"),
        onPositiveResponse: (response) {

          AppUser app_user=AppUser.fromJson(response.data[user]);
          interne_storage.write(tokens,response.data[tokens]);
          //interne_storage.write(client,response.data[client]);
          //interne_storage.write(user,response.data[user]);
          //interne_storage.write(notf,response.data[notf]);
          update(user: app_user);
          print("la réponse du login est donc ${response.data}");
          },
      ));

      if(reponse.status!)
      {

      }
      update(loading: true,
          success: reponse.status!,msg: reponse.message);
      /*if(reponse.message=="Authentification failed, check credentials!")
      {
        reponse.message="Utilisateur non identifié.Veuillez saisir les données correctes!";
      }
      */
      update(msg:reponse.message );
      await Future.delayed(const Duration(milliseconds: 500));
      print("le status final est ${reponse.status!}");

      return reponse.status!;
    } catch (e) {
      update(loading: false, success: false);
      return false;
    }
  }
  Future<bool> register({
    required String login, required String password,required String company,
    required String firstname,required String lastname,required String email,required String country,
  required String telephone,required String profil,required String sexe}) async {

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
              "password":password,
              "firstname": firstname,
              "lastname": lastname,
              "email": email,
              "country":country,
              "telephone": telephone,
              "company":company,
              "profil": 7,
              "sexe": sexe
            },
            headers: {
              //"X-API-KEY": header_code,
              "Authorization": 'Basic ${base64Encode(utf8.encode('$bearer_username:$bearer_password'))}',
              //'Content-Type': 'application/json'
            },
            method: "POST"),
        onPositiveResponse: (response) {


          update(account: response.account);
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
  Future<bool> activation_compte({required String password}) async {
    update(loading: true);
    update(msg: "Activation du compte  en cours ....");

    try {

      var data = {
        "code":state.data_code,
        "account":state.account,
        "password":password,
      };
      FormData formData=FormData.fromMap(data);
      ApiReponse reponse= await DioServices.withoutNothing().dispatch(
          httpRequest: DioServices(baseUrl: clientAuthBaseUrl).request(
              requestEndpoint: url_activation,
              payload: formData,
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
      interne_storage.write(portefeuilles,null);
      interne_storage.write(ktes,null);
      interne_storage.write(boutiks,null);
      interne_storage.write(cmpt,null);
      interne_storage.write(souscription,null);


      ref.invalidate(gettinCurrencyProvider);
      ref.invalidate(gettinWalletProvider);
      ref.invalidate(gettinCarteProvider);
      ref.invalidate(gettinCompteProvider);
      ref.invalidate(gettingSouscriptionProvider);
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
*/

  void update({
    AppUser? user, bool? loading, bool? success,
    String? msg,bool ? logout,String ? account,})
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


