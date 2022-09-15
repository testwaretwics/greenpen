import 'package:get/get.dart';
import 'package:green_pen/controller/booking_form_controller.dart';
import 'package:green_pen/controller/cart_controller.dart';

class BookingFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingFormController());
  }
}