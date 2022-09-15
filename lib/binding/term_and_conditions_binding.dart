import 'package:get/get.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/term_and_conditions_controller.dart';

class TermAndConditionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermAndConditionsController());
  }
}