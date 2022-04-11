import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_pen/screen/login/otp.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';
import 'package:green_pen/utils/preferences.dart';

class ForgotController extends GetxController{

  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> validation(BuildContext context, String userId) async {
    if (!userId.isEmpty) {
      getApiData(userId);
    } else {
      Get.snackbar('', 'Please enter Email Id or Mobile Number',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void getApiData(String mobile){
    Map<String, dynamic> input ={
      'mobile_number': mobile,
    };
    Get.dialog(loadingOverlay());
    APIProvider().forgotAPI(
      params: input,
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        Get.back();
        if(data.status==true){
          Preferences.addDataToSF(Preferences.USER_ID,data.userDetail!.userId);
          Get.toNamed(ROUTE_RESET_PASSWORD);
        }
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }
}