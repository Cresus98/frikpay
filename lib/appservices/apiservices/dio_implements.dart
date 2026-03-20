import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fripay/appservices/apiservices/dio_interfaces.dart';
import 'package:fripay/views/utils/extensions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../views/utils/constantes.dart';
import '../../views/utils/fonctions.dart';
import 'apireponse.dart';

enum RequestCase {
  Default,
  ResetWithMessageResetFormat,
  ResetSendCodeLong,
  RechargeBank,
  GetCurrency
}

class DioServices implements HttpServices {
  String baseUrl = "";
  DioServices({required this.baseUrl});
  DioServices.withoutNothing();

  /// Configure dio before
  final _dio = Dio(
    BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (code) => (code ?? 500) < 500,
      connectTimeout: 32.seconds,
      receiveTimeout: 32.seconds,
      sendTimeout: 32.seconds,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        logPrint: (stuff) => log('$stuff'),
        requestHeader: true,
        requestBody: true,
        maxWidth: 65536,
      ),
    );

  final _dio2 = Dio(
    BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (code) => (code ?? 500) < 500,
      connectTimeout: 60.seconds,
      receiveTimeout: 60.seconds,
      sendTimeout: 60.seconds,
    ),
  )..interceptors.add(
      PrettyDioLogger(
        logPrint: (stuff) => log('$stuff'),
        requestHeader: true,
        requestBody: true,
        maxWidth: 65536,
      ),
    );

  @override
  Future<ApiReponse> dispatch(
      {required Future<ApiReponse> httpRequest,
      ApiReponseCallBack? onPositiveResponse}) async {
    ApiReponse response = ApiReponse();
    response.status = false;
    try {
      response = await httpRequest;
      log("le log dans le response $response et le status est ${response.status!}");

      if (response.status!) {
        onPositiveResponse?.call(response);

        //if (response.error['details'] == null ||
        //  response.error['details']['field_errors'] is! List) {
        //Fluttertoast.showToast(msg: response.error['message']);
        //  } else {

        //Fluttertoast.showToast(msg: response.error!);

        //}
      }

      //else {
      // onPositiveResponse?.call(response);
      //if (response.message!.isNotEmpty) {
      // Fluttertoast.showToast(msg: response.message!);
      //}
      //}

      return response;
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.cancel:
          response.message = "Requête arrétée ,veuillez réessayer !";
           Fluttertoast.showToast(msg: "Request cancel ",
               toastLength: Toast.LENGTH_LONG,
           );
          break;

        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:

        response.message =   "Problème de Connexion Internet, veuillez vérifier cotre connexion et réessayez";
           Fluttertoast.showToast(msg:
          //response.message =
              "Problème de Connexion Internet, veuillez vérifier cotre connexion et réessayez",
               toastLength: Toast.LENGTH_LONG,
               //;
          );
          break;

        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:

        response.message ="Délai d'attente dépassé, réessayez svp!";
          Fluttertoast.showToast(msg:
          //response.message =
          "Délai d'attente dépassé, réessayez svp!",
              toastLength: Toast.LENGTH_LONG,
          //;
          );
          break;
        default:
          response.message = "Erreur lors du proceesus,veuillez réessayer";
          Fluttertoast.showToast(msg:
          //response.message =
          "Erreur lors du proceesus,veuillez réessayer",
              toastLength: Toast.LENGTH_LONG,
            //;
          //_l10n!.anErrorOccurred
          );
          break;
      }
    } catch (e) {

      Fluttertoast.showToast(
          msg: "Erreur lors du proceesus $e",
        toastLength: Toast.LENGTH_LONG,
        //_l10n!.anErrorOccurred
      );
      response.message = "Erreur lors du proceesus , veuillez réessayer";
      log("finlament on a l'erreur  dans le dispact  est la suivante $e");
    }

    return response;
  }

  @override
  Future<ApiReponse> request(
      {required String requestEndpoint,
      Map<String, dynamic>? headers,
      Object? payload,
      String? method,
      Map<String, dynamic>? params,
      RequestCase rcase = RequestCase.Default}) async {
    final response;
    if (rcase == RequestCase.ResetSendCodeLong) {
      response = await _dio2.request(baseUrl + requestEndpoint,
          options: Options(
            method: method ?? 'GET',
            headers: headers,
          ),
          data: payload,
          queryParameters: params);
    }
    else {
      response = await _dio.request(baseUrl + requestEndpoint,
          options: Options(
            method: method ?? 'GET',
            headers: headers,
          ),
          data: payload,
          queryParameters: params);
    }

    print("le data reponse request ${response.data}");

    ApiReponse reponse = ApiReponse();
    reponse.data = response.data;
    if (rcase == RequestCase.Default) {
      reponse.message = response.data['msg'];
    }
    else if (rcase == RequestCase.ResetWithMessageResetFormat) {
      reponse.message = response.data['message'];
    }
    else if (rcase == RequestCase.GetCurrency && response.data["status"] != succes) {
      reponse.message = response.data["msg"];
    }
    reponse.status = response.data["status"] == succes ? true : false;
    return reponse;
  }
}
