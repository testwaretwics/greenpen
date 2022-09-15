import 'package:get/get.dart';
import 'package:green_pen/controller/test_instructions_controller.dart';

class TestInstructionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestInstructionsController());
  }
}