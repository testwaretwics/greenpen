import 'package:get/get.dart';
import 'package:green_pen/controller/about_purchased_tests_controller.dart';

class AboutPurchasedTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutPurchasedTestController());
  }
}