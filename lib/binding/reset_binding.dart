import 'package:get/get.dart';
import 'package:green_pen/controller/forgot_controller.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/controller/reset_controller.dart';

class ResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetController());
  }
}