/* date: 06.08.21
* name: vennila
* task: forgot_password & login_change_logout(FORGOT,LOGIN_RESET,LOGIN_MOB) */
/*THEME*/
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as api;
import 'package:green_pen/utils/preferences.dart';

const UserThemeData = 'UserThemeData';

/*LANUGAE */
const String SAVE_LANG = 'SAVELANG';

/*PAGE ROUTER*/
const ROUTE_SPLASH = '/splash';
const ROUTE_LOGIN = '/login';
const ROUTE_OTP = '/OTP';
const ROUTE_REGISTER = '/register';
const ROUTE_HOME_PAGE = '/homePage';
const ROUTE_FORGOT_PASSWORD = '/forgotPassword';
const ROUTE_RESET_PASSWORD = '/resetPassword';
const ROUTE_RESET_SUCCESS = '/resetSuccess';
const ROUTE_DASHBOARD = '/dashboard';


/* PREF DATA */
const String FIREBASE_TOKEN = 'FIREBASE_TOKEN';
const String AUTH_CODE = 'AUTH_CODE';

String getLanguage(){

  return Preferences.getStringValuesSF(Preferences.SAVE_LANG) == 'en' || Preferences.getStringValuesSF(Preferences.SAVE_LANG) == null  ? '1' : '2';
}

String? convertMaptoString(Map<String,dynamic> value){
  return json.encode(value);
}

Map<String,dynamic>? convertStringtoMap(String value){
  return jsonDecode(value);
}
api.FormData inputParams(Map<String,dynamic> map){
  print('PARAMS:- $map' );
  return api.FormData.fromMap(map);
}

Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'token': '${Preferences.getStringValuesSF(Preferences.FIREBASE_TOKEN)}',
    'deviceType': 'ANDROID',
    'release': '${build.version.release}',
    'version': '${build.version.sdkInt}',
    'id': '${build.id}',
    'brand': '${build.brand}',
    'model': '${build.model}',
    'board': '${build.board}',
    'lang': getLanguage(),
  };
}

Map<String, dynamic> readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'token': '${Preferences.getStringValuesSF(Preferences.FIREBASE_TOKEN)}',
    'deviceType': 'IOS',
    'release': '${data.utsname.release}',
    'version': '${data.systemVersion}',
    'id': '${data.identifierForVendor}',
    'brand': '${data.model}',
    'model': '${data.name}',
    'board': '${data.systemName}',
    'lang': getLanguage(),
  };

}
