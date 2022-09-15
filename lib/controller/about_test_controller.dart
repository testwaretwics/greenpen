
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/model/buy_test_model.dart';
import 'package:green_pen/model/buy_test_details_model.dart' as buyTestDetail;
import 'package:green_pen/provider/api_provider.dart';

class AboutTestController extends GetxController{

  buyTestDetail.PackageDetail? buyTestDetailPackageDetailDataList;
  var mcqTestDataList = List<buyTestDetail.McqTest>.empty(growable: true).obs;
  var isLoading = false.obs;
  var packageId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    packageId = Get.arguments;
    print("Start");
    await apiCallingMethod(packageId);

    print("End");
    super.onInit();
  }


  Future<void> apiCallingMethod(packageId) async {
    await buyTestDetailsApiData(packageId);
  }

  Future<void> buyTestDetailsApiData(int packageId) async {
    isLoading.value = true;
    mcqTestDataList.clear();
    await APIProvider().buyTestDetailsAPI(
      id: packageId,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status==true){
          buyTestDetailPackageDetailDataList = data.result!.packageDetail!;

          data.result!.mcqTest!.forEach((mcqTest) {
            mcqTestDataList.add(mcqTest);
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