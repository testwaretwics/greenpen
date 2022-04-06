import 'package:get/get.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}