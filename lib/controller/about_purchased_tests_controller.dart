
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/provider/api_provider.dart';

import '../model/purchased_test_details_model.dart';

class AboutPurchasedTestController extends GetxController{

  PackageDetail? buyTestDetailPackageDetailDataList;
  var mcqTestDataList = List<McqTest>.empty(growable: true).obs;
  var isLoading = false.obs;
  var packageId;
  @override
  void dispose() {
    Get.delete<AboutPurchasedTestController>();
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    packageId = Get.arguments;
    print("Start");
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      await getApiCallingMethod(packageId);
    } else {
      Get.snackbar('Internet', 'No Internet Connection',
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    print("End");
    super.onInit();
  }

  Future<void> getApiCallingMethod(packageId) async {
    await purchasedTestDetailsApiData(packageId);
  }

  Future<void> purchasedTestDetailsApiData(packageId) async {
    isLoading.value = true;
    mcqTestDataList.clear();
    await APIProvider().purchasedTestDetailAPI(
      id: packageId,
      onSuccess: (data) {
        print('Response 11 purchasedTestDetailAPI : ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          buyTestDetailPackageDetailDataList = data.result!.packageDetail;
          data.result!.mcqTest!.forEach((element) {
            mcqTestDataList.add(element);
          });
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