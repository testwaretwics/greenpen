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

class ResetController extends GetxController{

  late bool passwordVisible;
  late bool cPasswordVisible;

  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();
  

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  Future<void> validation(
      BuildContext context, String pass, String confirmPass) async {
    if (!pass.isEmpty) {
      if (!confirmPass.isEmpty) {
        if (confirmPass == pass) {
          getApiData(pass, confirmPass);
        } else {
          Get.snackbar("", "Confirm Password should be same as New Password",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("", "Confirm Password should not be empty",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("", "New Password should not be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    passwordVisible = true;
    cPasswordVisible = true;
    super.onInit();
  }

  void getApiData(String password, String cPassword){
    Map<String, dynamic> input ={
      'user_id': Preferences.getStringValuesSF(Preferences.USER_ID),
      'new_password': password,
      'confirm_password': cPassword,
    };
    Get.dialog(loadingOverlay());
    APIProvider().resetAPI(
      params: input,
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        Get.back();
        if (data.status==true){
          //data.userDetail!.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID,data.userDetail!.userId);
            Preferences.addDataToSF(Preferences.USER_FIRST_NAME,data.userDetail!.firstName);
            Preferences.addDataToSF(Preferences.USER_LAST_NAME,data.userDetail!.lastName);
            Preferences.addDataToSF(Preferences.USER_EMAIL,data.userDetail!.email);
            Preferences.addDataToSF(Preferences.USER_MOBILE,data.userDetail!.mobileNo);
         // });

          Get.toNamed(ROUTE_RESET_SUCCESS);
        }else{
          Get.snackbar('', data.message.toString(),icon: const Icon(Icons.dangerous),
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }
}