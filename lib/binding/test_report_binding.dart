import 'package:get/get.dart';
import 'package:green_pen/controller/booking_form_controller.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/test_report_controller.dart';

class TestReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestReportController());
  }
}