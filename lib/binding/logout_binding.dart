import 'package:get/get.dart';
import 'package:green_pen/controller/logout_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoutController());
  }
}