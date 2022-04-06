import 'dart:convert';
import 'package:green_pen/model/forgot_password_model.dart';
import 'package:green_pen/model/home_model.dart';
import 'package:green_pen/model/login_model.dart';
import 'package:green_pen/model/register_model.dart';
import 'package:green_pen/model/reset_model.dart';
import 'package:green_pen/model/test_time_table_model.dart';
import 'package:green_pen/service/api_service.dart';
import 'package:green_pen/utils/urlUtils.dart';
/* date: 06.08.21
* name: vennila
* task: forgot_password (forgotAPI and resetApi added)*/
class APIProvider {
  void loginAPI({
    var params,
    Function()? beforeSend,
    Function(LoginModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiRequest(url: urlLogin, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        LoginModel res = LoginModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void registerAPI({
    var params,
    Function()? beforeSend,
    Function(RegisterModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiRequest(url: urlRegister, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        RegisterModel res = RegisterModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void forgotAPI({
    var params,
    Function()? beforeSend,
    Function(ForgotPasswordModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiRequest(url: urlForgot, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ForgotPasswordModel res = ForgotPasswordModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void resetAPI({
    var params,
    Function()? beforeSend,
    Function(ResetPasswordModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiRequest(url: urlReset, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ResetPasswordModel res = ResetPasswordModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void homeAPI({
    var params,
    Function()? beforeSend,
    Function(HomeModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiRequest(url: urlHome, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        HomeModel res = HomeModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  void testTimeTableAPI({
    var params,
    Function()? beforeSend,
    Function(TestTimeTableModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    ApiRequest(url: urlTestTimeTable, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TestTimeTableModel res = TestTimeTableModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

}





