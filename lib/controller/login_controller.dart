// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:green_pen/provider/api_provider.dart';
// import 'package:green_pen/utils/constant.dart';
// import 'package:green_pen/utils/loading_overlay.dart';
// import 'package:green_pen/utils/preferences.dart';
//
// class LoginController extends GetxController{
//
//   static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   Map<String, dynamic>? deviceData;
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool passwordVisible = false;
//
//   @override
//   void onInit() {
//     super.onInit();
//     passwordVisible = true;
//     getPlatformState();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> validation(
//       BuildContext context, String emailValue, String passwordValue) async {
//     if (!emailValue.isEmpty) {
//       /* if (!regExp.hasMatch(emailValue)) {*/
//       if (!passwordValue.isEmpty) {
//         // apiService = new APIService();
//         // isApiCallProcess = true;
//         // apiService.loginUserAPI(emailValue, passwordValue).then((value) => resultAPI(context,value)
//
//         // );
//         print("Awaiting....");
//         await getApiData(emailValue,passwordValue);
//
//         print("Awaiting....End");
//         //Get.to(() => OtpScreen(name: 'login',));
//       } else {
//         Get.snackbar('', 'Please Enter Password',
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//       /* } else {
//           snakbarMsg(context, Icons.person, "Please Enter Proper Email",
//               Colors.red, Colors.white);
//         }*/
//     } else {
//       Get.snackbar('', 'Please Enter Email',
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }
//
//
//   getPlatformState() async {
//     deviceData = <String, dynamic>{};
//
//     try {
//       if (Platform.isAndroid) {
//         deviceData =
//             readAndroidBuildData(await deviceInfoPlugin.androidInfo);
//       } else if (Platform.isIOS) {
//         deviceData = readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
//       }
//     } on PlatformException {
//       deviceData = <String, dynamic>{
//         'Error:': 'Failed to get platform version.'
//       };
//     }
//     //print(deviceData);
//   }
//
//   Future<String> getApiData(String email, String password) async{
//     Map<String, dynamic> input ={
//       'username': email,//'gayathriguna5@gmail.com',
//       'password': password,//'Admin@1',
//       'deviceinfo': json.encode(deviceData),
//     };
//     Get.dialog(loadingOverlay());
//     await APIProvider().loginAPI(
//       params: inputParams(input),
//       onSuccess: (data) {
//         print('Response : ${data.status}');
//         print('Token : ${data.jwtToken}');
//         Get.back();
//         if (data.status==true){
//           Preferences.addDataToSF(Preferences.AUTH_CODE,data.jwtToken);
//           data.userDetail!.forEach((element) {
//             Preferences.addDataToSF(Preferences.USER_ID,element.userId);
//             Preferences.addDataToSF(Preferences.USER_FIRST_NAME,element.firstName);
//             Preferences.addDataToSF(Preferences.USER_LAST_NAME,element.lastName);
//             Preferences.addDataToSF(Preferences.USER_EMAIL,element.email);
//             Preferences.addDataToSF(Preferences.USER_MOBILE,element.mobileNo);
//           });
//           Preferences.addDataToSF(Preferences.USER_EXIST,data.status);
//
//           Get.toNamed(ROUTE_OTP);
//         }else{
//           Get.snackbar('', data.message.toString(),icon: const Icon(Icons.dangerous),
//               backgroundColor: Colors.redAccent, colorText: Colors.white);
//         }
//       },
//       onError: (error) {
//         print('Error : ${error}');
//       },
//     );
//     update();
//     return "Response ...";
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_pen/binding/dashboard_binding.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/screen/dashboard/dashboard.dart';
import 'package:green_pen/service/network_info.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';
import 'package:green_pen/utils/preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:showcaseview/showcaseview.dart';

class LoginController extends GetxController{

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic>? deviceData;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool status = false;
  int count = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void onInit() {
    NetworkInfo.checkConnectivity(scaffoldKey);
    super.onInit();
    passwordVisible = true;
    getPlatformState();
    getSMSPermission();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Get permission for auto filled SMS.
  getSMSPermission() async {
    final status = await Permission.sms.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print('Denied. Show a dialog with a reason and again ask for the permission.');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
    }
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
        print("Awaiting....");
        var result = await (Connectivity().checkConnectivity());
        if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
          print("Connect");
          await getApiData(emailValue,passwordValue);
        } else {
          Get.snackbar('Internet', 'No Internet Connection',
              backgroundColor: Colors.red, colorText: Colors.white);
        }


        print("Awaiting....End");
        //Get.to(() => OtpScreen(name: 'login',));
      } else {
        Get.snackbar('Invalid', 'Please Enter Password',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      /* } else {
          snakbarMsg(context, Icons.person, "Please Enter Proper Email",
              Colors.red, Colors.white);
        }*/
    } else {
      Get.snackbar('Invalid', 'Please Enter Email',
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

  Future<void> getApiData(String email, String password) async{
    Map<String, dynamic> input ={
      'username': email,//'gayathriguna5@gmail.com',
      'password': password,//'Admin@1',
      'deviceinfo': json.encode(deviceData),
    };
    Get.dialog(loadingOverlay());
    await APIProvider().loginAPI(
      params: inputParams(input),
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Token : ${data.jwtToken}');
        Get.back();
        status = data.status!;
        if (data.status==true){
          Preferences.addDataToSF(Preferences.AUTH_CODE,data.jwtToken);
          data.userDetail!.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID,element.userId);
            Preferences.addDataToSF(Preferences.USER_FIRST_NAME,element.firstName);
            Preferences.addDataToSF(Preferences.USER_LAST_NAME,element.lastName);
            Preferences.addDataToSF(Preferences.USER_EMAIL,element.email);
            Preferences.addDataToSF(Preferences.USER_MOBILE,element.mobileNo);
          });
          Preferences.addDataToSF(Preferences.USER_EXIST,data.status);
          //Preferences.addDataToSF(Preferences.USER_SHOW_CASE_WIDGET,false);
          // Get.to(()=>
          //     ShowCaseWidget(
          //       onFinish: (){
          //         count +=1;
          //         print("Finished.....$count");
          //         if(count==4){
          //           Preferences.addDataToSF(Preferences.USER_SHOW_CASE_WIDGET,true);
          //         }
          //       },
          //       builder: Builder(
          //           builder : (_)=> Dashboard()
          //       ),
          //     ),
          //     binding: DashboardBinding());

          Get.offAllNamed(ROUTE_DASHBOARD);
        }else{
          Get.snackbar('Invalid', data.message.toString(),icon: const Icon(Icons.dangerous),
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