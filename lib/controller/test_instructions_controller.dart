
import 'dart:convert';

import 'package:get/get.dart';
import 'package:green_pen/model/test_panel_model.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/utils/preferences.dart';

class TestInstructionsController extends GetxController{

  var questionCollectionDataList = List<QuestionCollections>.empty(growable: true).obs;
  var instruction = ''.obs;
  var title = ''.obs;
  var total_time = ''.obs;
  var answered = ''.obs;
  var unanswered = ''.obs;
  var isLoading = false.obs;
  var loadingPercentage = 0.0.obs;

  var packageId;
  var testId;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Calle...... : ${Get.arguments}");
    packageId = Get.arguments[0];
    testId = Get.arguments[1];
    print("Start");
    await apiCallingMethod(packageId,testId);
    print("End");
    super.onInit();
  }

  Future<void> apiCallingMethod(packageId,testId) async {
    await testPanelApiData(packageId,testId);
  }

  Future<void> testPanelApiData(packageId,testId) async {
    isLoading.value = true;
    loadingPercentage.value = 0.1;
    questionCollectionDataList.clear();
    await APIProvider().testPanelAPI(
      id: [packageId,testId],
      onSuccess: (data) {
       loadingPercentage.value = 0.2;
        print('Response 11 testPanelAPI: ${data.status}');
        print('Response 22 : ${data.message}');
        if (data.status!){
       loadingPercentage.value = 0.03;
          instruction.value = data.instruction.toString();
          title.value = data.title.toString();
          total_time.value = data.totalTime.toString();
       loadingPercentage.value = 0.45;
          answered.value = data.answered.toString();
          print("answered.value :- --- ${data.answered.toString()}");
          unanswered.value = data.unanswered.toString();
       loadingPercentage.value = 0.55;
          data.questionCollections!.forEach((element) {
            questionCollectionDataList.add(element);
          });
       loadingPercentage.value = 0.7;
        }
       // loadingPercentage.value = 100.0;
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