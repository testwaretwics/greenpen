import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/get_menus_controller.dart';
import 'package:green_pen/model/home_model.dart';
import 'package:green_pen/model/test_time_table_model.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController{
 var  getMenusController = Get.put(GetMenusController());
 var homeDataList = List<HomeModel>.empty(growable: true).obs;
 var summaryForTestDataList = SummaryForTest();
 var rankScoredRecentlyDataList = List<RankScoredRecently>.empty(growable: true).obs;
 var testTimeTableDataList = List<TestTimeTable>.empty(growable: true).obs;
 var isLoading = false.obs;
 var userName = ''.obs;
 var userLastLogin = ''.obs;
 var userImage = ''.obs;
 DateTime selectedDate = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());

  @override
  void onInit()  {
    print("Dashboard Start....");
    //getAPICalled();
    super.onInit();
    print("Dashboard End....");
  }


 Future<void> getAPICalled() async {
   print("Awaiting....");
   var result = await (Connectivity().checkConnectivity());
   if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
     await getApiData();
     await getTestTimeTableApiData(DateTime.now().toString().split(" ").first);
     await getMenusController.getMenusApiData();
   } else {
     Get.snackbar('Internet', 'No Internet Connection',
         backgroundColor: Colors.red, colorText: Colors.white);
   }

   print("Awaiting....End");
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getApiData() async{
    homeDataList.clear();
    rankScoredRecentlyDataList.clear();
    isLoading.value = true;
   await APIProvider().homeAPI(
      onSuccess: (data) {
        print('Response : ${data.toJson()}');
        print('Response : ${data.lastLogin}');
        homeDataList.add(data);
        userName.value = data.userName!;
        userImage.value = data.userImage!;
        userLastLogin.value = data.lastLogin!;
        summaryForTestDataList.incompletedTest = data.summaryForTest!.incompletedTest;
        summaryForTestDataList.completedTest = data.summaryForTest!.completedTest;
        summaryForTestDataList.pendingTest = data.summaryForTest!.pendingTest;
        summaryForTestDataList.percentage = data.summaryForTest!.percentage;
        data.rankScoredRecently!.forEach((element) {
          rankScoredRecentlyDataList.add(element);
        });
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }

  Future<void> getTestTimeTableApiData(String date) async {
    Map<String, dynamic> input ={
      'date': date
    };
    isLoading.value = true;
    await APIProvider().testTimeTableAPI(
      params: input,
      onSuccess: (data) {
        testTimeTableDataList.clear();
        print('getTestTimeTableApiData : ${data.toJson()}');
        data.testTimeTable!.forEach((element) {
          testTimeTableDataList.add(element);
        });
        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }
}