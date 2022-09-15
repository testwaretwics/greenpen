import 'package:get/get.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/help_controller.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpController());
  }
}