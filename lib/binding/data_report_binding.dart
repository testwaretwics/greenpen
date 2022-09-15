import 'package:get/get.dart';
import 'package:green_pen/controller/data_report_controller.dart';

class DataReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataReportController());
  }
}