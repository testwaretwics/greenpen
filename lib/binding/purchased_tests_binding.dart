import 'package:get/get.dart';
import 'package:green_pen/controller/purchased_tests_controller.dart';

class PurchasedTestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PurchasedTestsController());
  }
}