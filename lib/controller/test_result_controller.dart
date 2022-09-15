
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/model/test_result_model.dart';
import 'package:green_pen/provider/api_provider.dart';

class TestResultController extends GetxController{

  var testResultDataList = List<TestResult>.empty(growable: true).obs;
  var categoryWithTestResultDataList = List<TestResult>.empty(growable: true).obs;
  var categoryDataList = List<CategoryList>.empty(growable: true).obs;
  var isLoading = false.obs;
  var tabCategoryId;

  GlobalKey eight = GlobalKey();
  GlobalKey nine = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Start");
   // await apiCallingMethod();
    print("End");
    super.onInit();
  }


  Future<void> apiCallingMethod() async {
    await getTestResultApiData();
  }

  Future<void> getTestResultApiData() async {
    isLoading.value = true;
    testResultDataList.clear();
    categoryDataList.clear();
    await APIProvider().testResultAPI(
      onSuccess: (data) {
        print('Response 11 testResultAPI: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          tabCategoryId = data.result!.categoryList![0].id;
          data.result!.testResult!.forEach((testResult) {
            testResultDataList.add(testResult);
          });
          data.result!.categoryList!.forEach((category) {
            categoryDataList.add(category);
          });

          getCategoryWithTestResultDataList(tabCategoryId);

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

  getCategoryWithTestResultDataList(tabCategoryId){
    categoryWithTestResultDataList.clear();
    print("tabCategoryId : $tabCategoryId");
    for(int i=0; i<testResultDataList.length; i++){
      if(testResultDataList[i].categoryId==tabCategoryId){
        categoryWithTestResultDataList.add(testResultDataList[i]);
      }
    }
    update();
    print("Length : ${categoryWithTestResultDataList.length}");
  }
}