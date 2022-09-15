/* date: 06.08.21
* name: vennila
* task: forgot_password & login_change_logout(FORGOT,LOGIN_RESET,LOGIN_MOB) */
/*THEME*/
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart' as api;
import 'package:flutter/material.dart';
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
const ROUTE_LOGIN_SUCCESS = '/loginSuccess';
const ROUTE_DASHBOARD = '/dashboard';
const ROUTE_PROFILE_INFO = '/profileInfo';
const ROUTE_HELP = '/help';
const ROUTE_PRIVACY_POLICY = '/privacyPolicy';
const ROUTE_TERM_AND_CONDITIONS = '/termAndConditions';
const ROUTE_NOTIFICATION = '/notification';
const ROUTE_NOTIFICATION_READ = '/notificationRead';
const ROUTE_TEST_DETAILS = '/testDetails';
const ROUTE_UNIT_TEST_DETAILS = '/unitTestDetails';
const ROUTE_ABOUT_TEST = '/aboutTest';
const ROUTE_CART = '/cart';
const ROUTE_BOOK_FORM = '/bookForm';
const ROUTE_TEST_INSTRUCTIONS = '/testInstructions';
const ROUTE_TEST_PAGE = '/testPage';
const ROUTE_PURCHASED_TESTS = '/purchasedTests';
const ROUTE_ABOUT_PURCHASED_TESTS = '/aboutPurchasedTests';
const ROUTE_TEST_REPORT = '/testReport';
const ROUTE_MARK_ANALYSIS = '/markAnalysis';
const ROUTE_DATA_REPORT = '/dataReport';
const ROUTE_TEST_SYLLABUS = '/testSyllabus';
const ROUTE_ABOUT_TEST_STATUS = '/aboutTestStatus';

  // Global Variable
final one = GlobalKey();
final two = GlobalKey();
final three = GlobalKey();


/* PREF DATA */
const String FIREBASE_TOKEN = 'FIREBASE_TOKEN';
const String AUTH_CODE = 'AUTH_CODE';

String getLanguage() {
  return Preferences.getStringValuesSF(Preferences.SAVE_LANG) == 'en' ||
          Preferences.getStringValuesSF(Preferences.SAVE_LANG) == null
      ? '1'
      : '2';
}

String? convertMaptoString(Map<String, dynamic> value) {
  return json.encode(value);
}

Map<String, dynamic>? convertStringtoMap(String value) {
  return jsonDecode(value);
}

api.FormData inputParams(Map<String, dynamic> map) {
  print('PARAMS:- $map');
  return api.FormData.fromMap(map);
}

Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'token': '${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}',
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
    'token': '${Preferences.getStringValuesSF(Preferences.AUTH_CODE)}',
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
