


import 'package:fripay/appservices/apiservices/apireponse.dart';

typedef ApiReponseCallBack=Function(ApiReponse);

abstract class HttpServices {

  Future<ApiReponse> request({
    required String requestEndpoint,
    Map<String, dynamic>? headers,
    Object? payload,
    String? method,
    Map<String, dynamic>? params,
  });

  //Future<bool> dispatch({
  Future<ApiReponse> dispatch({
    required Future<ApiReponse> httpRequest,
    ApiReponseCallBack? onPositiveResponse,
  });
}