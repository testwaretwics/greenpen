import 'package:get/get.dart';
import 'package:green_pen/controller/forgot_controller.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/controller/take_test_detail_controller.dart';

class TestDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TakeTestDetailController());
  }
}