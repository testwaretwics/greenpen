
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/provider/api_provider.dart';

import '../model/purchased_tests_model.dart';

class PurchasedTestsController extends GetxController{

  var categoryDataList = List<Category>.empty(growable: true).obs;
  var packageDetailDataList = List<PackageDetail>.empty(growable: true).obs;
  var categoryWithPackageDetailDataList = List<PackageDetail>.empty(growable: true).obs;
  var isLoading = false.obs;
  var tabCategoryId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Start");
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      await getApiCallingMethod();
    } else {
      Get.snackbar('Internet', 'No Internet Connection',
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    print("End");
    super.onInit();
  }

  Future<void> getApiCallingMethod() async {
    await purchasedTestsApiData();
  }

  Future<void> purchasedTestsApiData() async {
    isLoading.value = true;
    categoryDataList.clear();
    packageDetailDataList.clear();
    await APIProvider().purchasedTestsAPI(
      onSuccess: (data) {
        print('Response 11   : ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          tabCategoryId = data.result!.category![0].id;
          data.result!.category!.forEach((element) {
            categoryDataList.add(element);
          });

          data.result!.packageDetail!.forEach((element) {
            packageDetailDataList.add(element);
          });
          getCategoryWithPackageDetailDataList(tabCategoryId);

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

  getCategoryWithPackageDetailDataList(tabCategoryId){
    categoryWithPackageDetailDataList.clear();
    print("tabCategoryId : $tabCategoryId");
    for(int i=0; i<packageDetailDataList.length; i++){
      if(packageDetailDataList[i].categoryId==tabCategoryId){
        categoryWithPackageDetailDataList.add(packageDetailDataList[i]);
      }
    }
    update();
    print("Length : ${categoryWithPackageDetailDataList.length}");
  }

  Future<void> purchasedTestDetailsApiData() async {
    isLoading.value = true;
    await APIProvider().purchasedTestDetailAPI(
      id: 1,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){

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