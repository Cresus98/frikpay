
class ApiReponse<T> {
  T? data;
  String? message;
  String? account;
  bool status;
  String? errorCode;

  ApiReponse({this.data, this.message, this.account, this.status = false, this.errorCode});
}