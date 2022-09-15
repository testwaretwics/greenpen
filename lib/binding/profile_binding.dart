import 'package:get/get.dart';
import 'package:green_pen/controller/dashboard_controller.dart';
import 'package:green_pen/controller/forgot_controller.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}