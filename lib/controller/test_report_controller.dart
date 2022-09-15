import 'package:get/get.dart';
import 'package:green_pen/model/test_report_model.dart';
import 'package:green_pen/provider/api_provider.dart';

class TestReportController extends GetxController{

  TestResult? testResultDataList;
  var isLoading = false.obs;
  var id; var backButton = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    id = Get.arguments[0];
    backButton = Get.arguments[1];
    print("Start $id - $backButton");
    await apiCallingMethod(id);
    print("End");
    super.onInit();
  }


  Future<void> apiCallingMethod(id) async {
    await getTestReportApiData(id);
  }

  Future<void> getTestReportApiData(int id) async {
    isLoading.value = true;
    await APIProvider().testReportAPI(
      id: id,
      onSuccess: (data) {
        print('Response 11: ${data.status}');
        print('Response 22: ${data.message}');
        if (data.status!){
          testResultDataList = data.result!.testResult!;
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