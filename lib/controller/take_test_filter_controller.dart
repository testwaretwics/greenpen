
import 'package:get/get.dart';
import 'package:green_pen/screen/login/otp.dart';
import 'package:green_pen/provider/api_provider.dart';
import 'package:green_pen/screen/login/reset_success.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/loading_overlay.dart';

class TakeTestFilter2Controller extends GetxController{

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getApiData() async {
    Get.dialog(loadingOverlay());
    await APIProvider().takeTestFilterAPI(
      id: 1,
      onSuccess: (data) {
        print('Response : ${data.status}');
        print('Response : ${data.message}');
        if (data.status==true){

        }else{

        }
      },
      onError: (error) {
        print('Error : ${error}');
      },
    );
    update();
  }
}