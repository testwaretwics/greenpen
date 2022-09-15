
import 'package:get/get.dart';
import 'package:green_pen/provider/api_provider.dart';

class PurchasedTestDetailsController extends GetxController{

  var isLoading = false.obs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    print("Start");
    await purchasedTestDetailsApiDataCalling();
    print("End");
    super.onInit();
  }

  Future<void> purchasedTestDetailsApiDataCalling() async {
    await purchasedTestDetailsApiData();
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