import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_pen/screen/login/otp.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/screen/login/reset_success.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';
import 'package:green_pen/utils/preferences.dart';

class DashboardController extends GetxController{

  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void tabChange(int index){
    selectedIndex = index;
    update();
  }
}