import 'package:get/get.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/privacy_policy_controller.dart';

class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyController());
  }
}