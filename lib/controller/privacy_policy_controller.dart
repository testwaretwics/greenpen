
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/provider/api_provider.dart';

class PrivacyPolicyController extends GetxController{

  var isLoading = false.obs;
  var message = ''.obs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Start");
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      await apiCallingMethod();
    } else {
      Get.snackbar('Internet', 'No Internet Connection',
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    print("End");
    super.onInit();
  }

  Future<void> apiCallingMethod() async {
    await getPrivacyPolicyApiData();
  }

  Future<void> getPrivacyPolicyApiData() async {
    isLoading.value = true;
    await APIProvider().privacyPolicyAPI(
      onSuccess: (data) {
        print('Response 11 privacyPolicyAPI: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          message.value = data.message.toString();
        }
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
        isLoading.value = false;
      },
    );
    update();
  }
}