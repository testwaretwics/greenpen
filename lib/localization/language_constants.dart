import 'package:flutter/material.dart';
import 'package:green_pen/utils/preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'demo_localization.dart';


//languages code
const String ENGLISH = 'en';
const String HINDI = 'hi';
const String TAMIL = 'ta';

Future<Locale> setLocale(String languageCode) async {
 await Preferences.addDataToSF(Preferences.USER_LANGUAGE,languageCode);
 print('USER SET LOCALE LANGUAGE : $languageCode');
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = await Preferences.getStringValuesSF(Preferences.USER_LANGUAGE)  ?? "en";
  print('USER GET LOCALE LANGUAGE : $languageCode');
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case TAMIL:
      return Locale(TAMIL, "IN");
    case HINDI:
      return Locale(HINDI, "IN");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.translate(key);
}
