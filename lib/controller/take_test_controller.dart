
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/model/take_test_model.dart' as takeTest;
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/utils/loading_overlay.dart';

class TakeTestController extends GetxController{

  var orderDataList = List<takeTest.Order>.empty(growable: true).obs;
  var categoryDataList = List<takeTest.Category>.empty(growable: true).obs;
  var categoryWithOrderDataList = List<takeTest.Order>.empty(growable: true).obs;
  var isLoading = false.obs;
  var tabCategoryId;

  GlobalKey ten = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Start");
    //await takeTestApiDataCalling();
    print("End");
    super.onInit();
  }

  Future<void> getApiCallingMethod() async {
   await takeTestApiData();
  }

 Future<void> takeTestApiData() async {
   isLoading.value = true;
   orderDataList.clear();
   categoryDataList.clear();
   await APIProvider().takeTestAPI(
     // params: input,
      onSuccess: (data) {
        print('Response 11 Test Test: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          tabCategoryId = data.result!.category![0].id;
          data.result!.order!.forEach((order) {
            orderDataList.add(order);
          });
          data.result!.category!.forEach((category) {
            categoryDataList.add(category);
          });
          getCategoryWithOrderDetailDataList(tabCategoryId);

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

  getCategoryWithOrderDetailDataList(tabCategoryId){
    categoryWithOrderDataList.clear();
    print("tabCategoryId : $tabCategoryId");
    for(int i=0; i<orderDataList.length; i++){
      if(orderDataList[i].categoryId==tabCategoryId){
        categoryWithOrderDataList.add(orderDataList[i]);
      }
    }
    update();
    print("Length : ${categoryWithOrderDataList.length}");
  }

}