import 'package:get/get.dart';
import 'package:green_pen/controller/booking_form_controller.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/mark_analysis_controller.dart';

class MarkAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MarkAnalysisController());
  }
}