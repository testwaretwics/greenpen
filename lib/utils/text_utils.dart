// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TextUtils {

  static String interFontFamily = 'Inter';

  /* SIZE OF THE FONT */
  static  double smallTextSize = 12.0 / Get.textScaleFactor;
  static  double hintTextSize = 14.0 / Get.textScaleFactor;
  static  double mediumTextSize = 15.0 / Get.textScaleFactor;
  static  double commonTextSize = 16.0 / Get.textScaleFactor;
  static  double commonTextSize18 = 18.0 / Get.textScaleFactor;
  static  double headerTextSize = 20.0 / Get.textScaleFactor;
  static  double mediumHeaderTextSize = 24.0 / Get.textScaleFactor;
  static  double superHeaderTextSize = 34.0 / Get.textScaleFactor;

  /* THINNESS OF THE FONT LETTER */
  static const FontWeight normalTextWeight = FontWeight.w400;
  static const FontWeight mediumtTextWeight = FontWeight.w500;
  static const FontWeight titleTextWeight = FontWeight.w600;
  static const FontWeight headerTextWeight = FontWeight.w700;
  static const FontWeight superHeaderTextWeight = FontWeight.w800;
  static const FontWeight boldHeaderTextWeight = FontWeight.bold;
}