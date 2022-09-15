
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/provider/api_provider.dart';

import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';
import 'package:green_pen/utils/preferences.dart';

class LogoutController extends GetxController{

  final loginController = Get.put(LoginController());
  var showCaseValue;

  @override
  void dispose() {

    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getLogoutApiData()async {

    Get.dialog(loadingOverlay());
    await APIProvider().logoutAPI(
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        if (data.status==true){
          showCaseValue = Preferences.getBoolValuesSF(Preferences.USER_SHOW_CASE_WIDGET);
          Preferences.clearAllValuesSF();
          Preferences.addDataToSF(Preferences.USER_SHOW_CASE_WIDGET,showCaseValue);
          Get.offAllNamed(ROUTE_LOGIN);
          loginController.emailController.clear();
          loginController.passwordController.clear();
          Get.snackbar('Logout', data.message.toString(),icon: const Icon(Icons.dangerous),
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      },
      onError: (error) {
        print('Error : $error');
      },
    );
    update();
  }
}