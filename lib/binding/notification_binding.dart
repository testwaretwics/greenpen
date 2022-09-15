import 'package:get/get.dart';
import 'package:green_pen/controller/dashboard_controller.dart';
import 'package:green_pen/controller/forgot_controller.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}