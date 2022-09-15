import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_pen/screen/login/otp.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/service/network_info.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';
import 'package:green_pen/utils/preferences.dart';

class RegisterController extends GetxController{

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic>? deviceData;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  var newUserOTP;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> validation(BuildContext context, String emailValue, String fName,
      String lName, String mobileNum, String passwordValue) async {
    if (!fName.isEmpty) {
      if (!lName.isEmpty) {
        if (!emailValue.isEmpty) {
          if (!mobileNum.isEmpty) {
            /* if (!regExp.hasMatch(emailValue)) {*/
            if (!passwordValue.isEmpty) {

              var result = await (Connectivity().checkConnectivity());
              if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                await getApiData(fName, lName, emailValue, mobileNum, passwordValue);
              } else {
                Get.snackbar('Internet', 'No Internet Connection',
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
              // apiService = new APIService();
              // isApiCallProcess = true;
              // apiService.loginUserAPI(emailValue, passwordValue).then((value) => resultAPI(context,value)

              // );
              //Get.to(() => OtpScreen(name: 'register',));

            } else {
              Get.snackbar("Invalid", "Please Enter Password",
                  backgroundColor: Colors.red, colorText: Colors.white,icon: Icon(Icons.warning));
            }
          } else {
            Get.snackbar("Invalid", "Please Enter Mobile Number",
                backgroundColor: Colors.red, colorText: Colors.white,icon: Icon(Icons.warning));
          }
        } else {
          Get.snackbar("Invalid", "Please Enter Email Id",
              backgroundColor: Colors.red, colorText: Colors.white,icon: Icon(Icons.warning));
        }
      } else {
        Get.snackbar("Invalid", "Please Enter Last Name",
            backgroundColor: Colors.red, colorText: Colors.white,icon: Icon(Icons.warning));
      }
    }
    /* } else {
          snakbarMsg(context, Icons.person, "Please Enter Proper Email",
              Colors.red, Colors.white);
        }*/
    else {
      Get.snackbar("Invalid", "Please Enter First Name",
          backgroundColor: Colors.red, colorText: Colors.white,icon: Icon(Icons.warning));
    }
  }

  @override
  void onInit() {
    NetworkInfo.checkConnectivity(scaffoldKey);
    passwordVisible = true;
    super.onInit();
    getPlatformState();
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

  Future<void> getApiData(String firstname, String lastname, String email, String mobile, String password)async {
    Map<String, dynamic> input ={
      'first_name': firstname, //'User',
      'last_name': lastname, //'Test',
      'email': email, //'testing2we@gmail.com',
      'mobile_no': mobile, //'9087654321',
      'password': password, //'test123',
      'deviceinfo': json.encode(deviceData),
    };
    Get.dialog(loadingOverlay());
    await APIProvider().registerAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        Get.back();
        if (data.status==true){
          Preferences.addDataToSF(Preferences.AUTH_CODE,data.jwtToken);
          data.userDetail!.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID,element.userId);
            Preferences.addDataToSF(Preferences.USER_FIRST_NAME,element.firstName);
            Preferences.addDataToSF(Preferences.USER_LAST_NAME,element.lastName);
            Preferences.addDataToSF(Preferences.USER_EMAIL,element.email);
            Preferences.addDataToSF(Preferences.USER_MOBILE,element.mobileNo);
            newUserOTP = element.otp;
          });

          Preferences.addDataToSF(Preferences.USER_EXIST,data.status);
          Preferences.addDataToSF(Preferences.USER_SHOW_CASE_WIDGET,false);
          Get.toNamed(ROUTE_OTP,arguments: [newUserOTP,mobile,"Register"]);
        }else{
          Get.snackbar('', data.message.toString(),icon: const Icon(Icons.dangerous),
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      },
      onError: (error) {
        print('Error : ${error}');
        Get.back();
      },
    );
    update();
  }
}