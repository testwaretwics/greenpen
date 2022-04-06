import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences prefs;

  static final String USER_ACTIVE = "USER_ACTIVE";
  static final String USER_NAME = 'USER_NAME';
  static final String USER_FIRST_NAME = 'USER_FIRST_NAME';
  static final String USER_LAST_NAME = 'USER_LAST_NAME';
  static final String USER_ID = "USER_ID";
  static final String USER_EMAIL = "USER_EMAIL";
  static final String USER_IMAGE = "USER_IMAGE";
  static final String USER_MOBILE = "USER_MOBILE";
  static final String USER_EXIST = "USER_EXIST";
  static final String USER_MEDIUM = "USER_MEDIUM";
  static final String USER_PASSWORD = "USER_PASSWORD";
  static final String USER_GENDER = "USER_GENDER";
  static final String USER_STD = "USER_STD";
  static final String USER_SEC = "USER_SEC";
  static final String USER_DOB = "USER_DOB";
  static final String USER_SCHOOL = "USER_SCHOOL";
  static final String USER_HM = "USER_HM";
  static final String USER_LANGUAGE = 'USER_LANGUAGE';

  static final String MEETING_URL = "MEETING_URL";
  static final String MATERIAL_VIDEO_URL = "MATERIAL_VIDEO_URL";
  static final String MATERIAL_PDF_URL = "MATERIAL_PDF_URL";


  /* PREF DATA */
  static String FIREBASE_TOKEN = 'FIREBASE_TOKEN';
  static String AUTH_CODE = 'AUTH_CODE';
  static String SAVE_LANG = 'SAVE_LANG';

  // ignore: always_declare_return_types
  static addDataToSF(String key, var value) async {
    prefs = await SharedPreferences.getInstance();
    print(
        'PREFERENCES DATA TYPE : KEY = ${key}        ||     VALUE = ${value}       ||     DATA TYPE = ${value.runtimeType}  ');
    switch (value.runtimeType) {
      case String:
        {
          await prefs.setString(key, value);
        }
        break;
      case int:
        {
          await prefs.setInt(key, value);
        }
        break;
      case double:
        {
          await prefs.setDouble(key, value);
        }
        break;
      case bool:
        {
          await prefs.setBool(key, value);
        }
    }
  }

  static Future<String?>? getStringValuesSF(String key) async {
    prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  Future<String?> getStringValueSF(String key) async {
    print('GET STRING VALUE : $key');
    prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  static Future<bool?>? getBoolValuesSF(String key) async {
    prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(key);
    return boolValue;
  }

  static Future<int?>? getIntValuesSF(String key) async {
    prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(key);
    return intValue;
  }

  static Future<double?>? getDoubleValuesSF(String key) async {
    prefs = await SharedPreferences.getInstance();
    //Return double
    double? doubleValue = prefs.getDouble(key);
    return doubleValue;
  }

  static clearAllValuesSF() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
