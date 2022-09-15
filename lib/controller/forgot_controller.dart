import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';
import 'package:green_pen/utils/preferences.dart';

class ForgotController extends GetxController{

  final TextEditingController textController = TextEditingController();
  var userOTP;
  var userMobile;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> validation(BuildContext context, String userId) async {
    if (!userId.isEmpty && userId.length>=10) {
      var result = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        await getApiData(userId);
      } else {
        Get.snackbar('Internet', 'No Internet Connection',
            backgroundColor: Colors.red, colorText: Colors.white);
      }

    } else {
      Get.snackbar('Invalid', 'Please enter Email Id or Mobile Number',
          backgroundColor: Colors.red, colorText: Colors.white,icon: Icon(Icons.warning));
    }
  }

  Future<void> getApiData(String mobile) async {
    Map<String, dynamic> input ={
      'mobile_number': mobile,
    };
    Get.dialog(loadingOverlay());
    await APIProvider().forgotAPI(
      params: input,
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        Get.back();
        if(data.status!){
          data.userDetail!.forEach((element) {
            Preferences.addDataToSF(Preferences.USER_ID,element.userId);
            Preferences.addDataToSF(Preferences.USER_MOBILE,element.mobileNo);
            userMobile = element.mobileNo;
            userOTP = element.otp;
          });
          Get.toNamed(ROUTE_OTP,arguments: [userOTP,userMobile,"Forgot"]);
        }else{
          Get.snackbar("Invalid", data.message!,
              colorText:Colors.white,
              backgroundColor: Colors.redAccent,
              icon: Icon(Icons.warning));
        }
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }
}