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

class LoginController extends GetxController{

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic>? deviceData;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void onInit() {
    super.onInit();
    passwordVisible = true;
    getPlatformState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> validation(
      BuildContext context, String emailValue, String passwordValue) async {
    if (!emailValue.isEmpty) {
      /* if (!regExp.hasMatch(emailValue)) {*/
      if (!passwordValue.isEmpty) {
        // apiService = new APIService();
        // isApiCallProcess = true;
        // apiService.loginUserAPI(emailValue, passwordValue).then((value) => resultAPI(context,value)

        // );
        getApiData(emailValue,passwordValue);
        //Get.to(() => OtpScreen(name: 'login',));
      } else {
        Get.snackbar('', 'Please Enter Password',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      /* } else {
          snakbarMsg(context, Icons.person, "Please Enter Proper Email",
              Colors.red, Colors.white);
        }*/
    } else {
      Get.snackbar('', 'Please Enter Email',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


  getPlatformState() async {
    deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData =
            readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    //print(deviceData);
  }

  void getApiData(String email, String password){
    Map<String, dynamic> input ={
      'username': email,//'gayathriguna5@gmail.com',
      'password': password,//'Admin@1',
      'deviceinfo': json.encode(deviceData),
    };
    Get.dialog(loadingOverlay());
    APIProvider().loginAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Token : ${data.jwtToken}');
        Get.back();
        if (data.status==true){
          Preferences.addDataToSF(Preferences.AUTH_CODE,data.jwtToken);
          Preferences.addDataToSF(Preferences.USER_ID,data.userDetail!.userId);
          Preferences.addDataToSF(Preferences.USER_FIRST_NAME,data.userDetail!.firstName);
          Preferences.addDataToSF(Preferences.USER_LAST_NAME,data.userDetail!.lastName);
          Preferences.addDataToSF(Preferences.USER_EMAIL,data.userDetail!.email);
          Preferences.addDataToSF(Preferences.USER_MOBILE,data.userDetail!.mobileNo);
          Preferences.addDataToSF(Preferences.USER_EXIST,data.status);
          Get.toNamed(ROUTE_OTP);
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