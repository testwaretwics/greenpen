
import 'package:dio/dio.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/preferences.dart';
/* date: 04.08.21
* name: vennila
* task: login_register_otp_api*/
class ApiRequest {
  final String url;
  final Map<String, dynamic>? params;
  var formdataParams;

  ApiRequest({
    required this.url,
    this.params,
    this.formdataParams
  });

  Dio _dio() {
    // Put your authorization token here
    return Dio(BaseOptions(headers: {
    'Accept': 'application/json',
    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGVtby5ncmVlbnBlbi5pblwvYXBpXC92MVwvbG9naW4iLCJpYXQiOjE2NDkyMTc4NjksImV4cCI6MTY0OTIyMTQ2OSwibmJmIjoxNjQ5MjE3ODY5LCJqdGkiOiI4WThMR2E0M0FDTzJFUEZDIiwic3ViIjoxOTEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.r8f3ckQHzT1BKQjBrWnk4S0M9ND6XlyRrRRNv9sWe8c",
    //"Authorization": "Bearer ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}"
    },
      responseType: ResponseType.json,
      connectTimeout: 30000,
      receiveTimeout: 30000,));
  }

  Future<void> get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {

    print('GET METHOD DATA  URLS :- $url \n PARAMS :- $params');
    _dio().get(url, queryParameters: params).then((res) {
      print("Response : ${res.statusCode}");
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print("Response Error : ${error}");
      if (onError != null) onError(_handleError(error));
    });
  }

  void postWithData({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {  print(' POST METHOD  DATA  URLS :- $url \n PARAMS :- $params');
       // print("Authorization : ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}");
    _dio().post(url, data: formdataParams).then((res) {
      if (onSuccess != null) onSuccess(res);
    }).catchError((error) {
      print('ERROR VALUE $error');
      if (onError != null) onError(_handleError(error));
    });
  }

  void postWithQuery({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {  print(' POST METHOD  DATA  URLS :- $url \n PARAMS :- $params');
  //print("Authorization : ${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}");
  _dio().post(url, queryParameters: params).then((res) {
    print('Log...${res.statusCode}');
    if (onSuccess != null) onSuccess(res);
  }).catchError((error) {
    print('ERROR VALUE $error');
    print('Log...${error}');
    if (onError != null) onError(_handleError(error));
  });
  }

  void postWithfile({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {  print(' POST METHOD WITH FILE  DATA  URLS :- $url \n PARAMS :- $formdataParams');

  _dio().post(url, data: formdataParams).then((res) {
    if (onSuccess != null) onSuccess(res);
  }).catchError((error) {
    print('ERROR VALUE $error');
    if (onError != null) onError(_handleError(error));
  });
  }



}


String _handleError(DioError error) {
  String? errorDescription = '';

  switch (error.type) {
    case DioErrorType.cancel:
      errorDescription = 'Request to API server was cancelled';
      break;
    case DioErrorType.connectTimeout:
      errorDescription = 'Connection timeout with API server';
      break;
    case DioErrorType.other:
      errorDescription =
      'Connection to API server failed due to internet connection';
      break;
    case DioErrorType.receiveTimeout:
      errorDescription = 'Receive timeout in connection with API server';
      break;
    case DioErrorType.response:
      errorDescription =
      'Error : ${error.response!.statusCode} - ${error.response!.statusMessage}';
      break;
    case DioErrorType.sendTimeout:
      errorDescription = 'Send timeout in connection with API server';
      break;
  }
      return errorDescription;

}
