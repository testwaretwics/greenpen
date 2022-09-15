
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/model/buy_test_model.dart';
import 'package:green_pen/model/buy_test_details_model.dart' as buyTestDetail;
import 'package:green_pen/provider/api_provider.dart';

class BuyTestController extends GetxController{

  var categoryDataList = List<Category>.empty(growable: true).obs;
  var packageDetailDataList = List<PackageDetail>.empty(growable: true).obs;
  var categoryWithPackageDetailDataList = List<PackageDetail>.empty(growable: true).obs;
  var isLoading = false.obs;
  var tabCategoryId;

  GlobalKey four = GlobalKey();
  GlobalKey five = GlobalKey();
  GlobalKey six = GlobalKey();
  GlobalKey seven = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Start");
    //await apiCallingMethod();
    print("End");
    super.onInit();
  }

  Future<void> apiCallingMethod() async {
    await buyTestApiData();
    await Get.put(CartController()).getCartApiData();
  }

  Future<void> buyTestApiData() async {
    isLoading.value = true;
    categoryDataList.clear();
    packageDetailDataList.clear();
    await APIProvider().buyTestAPI(
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status==true){
          tabCategoryId = data.result!.category![0].id;
          data.result!.category!.forEach((category) {
            categoryDataList.add(category);
          });
          data.result!.packageDetail!.forEach((package) {
            packageDetailDataList.add(package);
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

  Future<void> buyTestFilterApiData() async {
    // Map<String, dynamic> input ={

    // };
    // Get.dialog(loadingOverlay());
    isLoading.value = true;
    await APIProvider().buyTestFilterAPI(
      // params: input,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status==true){


        }else{

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