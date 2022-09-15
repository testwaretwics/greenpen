import 'dart:async';
import 'package:get/get.dart';
import 'package:green_pen/model/mark_analysis_model.dart';
import 'package:green_pen/provider/api_provider.dart';

class MarkAnalysisController extends GetxController{

  TestResult? testResultData;
  var questionDataList = List<QuestionData>.empty(growable: true).obs;
  var isLoading = false.obs;
  var id;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    id = Get.arguments;
    print("Start");
    await apiCallingMethod(id);
    print("End");
    super.onInit();
  }


  Future<void> apiCallingMethod(id) async {
    await getMarkAnalysisApiData(id);
  }

  Future<void> getMarkAnalysisApiData(int id) async {
    isLoading.value = true;
    questionDataList.clear();
    Timer.periodic(Duration(seconds: 3), (timer) {
      isLoading.value = false;
      timer.cancel();
    });
    await APIProvider().markAnalysisAPI(
      id: id,
      onSuccess: (data) {
        print('Response 11 markAnalysisAPI: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status==true){
          testResultData = data.result!.testResult!;

          data.result!.questionData!.forEach((question) {
            questionDataList.add(question);
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