import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:green_pen/model/home_model.dart';
import 'package:green_pen/screen/login/otp.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/screen/login/reset_success.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';
import 'package:green_pen/utils/preferences.dart';

class HomeController extends GetxController{

 var homeDataList = List<HomeModel>.empty(growable: true).obs;
 var summaryForTestDataList = SummaryForTest();
 var rankScoredRecentlyDataList = List<RankScoredRecently>.empty(growable: true).obs;
 var isLoading = false.obs;
 var userName = ''.obs;
 var userLastLogin = ''.obs;
 var userImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getApiData();
    getTestTimeTableApiData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getApiData(){
    homeDataList.clear();
    rankScoredRecentlyDataList.clear();
    isLoading.value = true;
    APIProvider().homeAPI(
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

  void getTestTimeTableApiData(){
    isLoading.value = true;
    APIProvider().testTimeTableAPI(
      onSuccess: (data) {
        print('getTestTimeTableApiData : ${data.toJson()}');

        isLoading.value = false;
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }
}