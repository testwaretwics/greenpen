
// ignore_for_file: avoid_classes_with_only_static_members

import 'package:get/get.dart';
import 'package:green_pen/binding/dashboard_binding.dart';
import 'package:green_pen/binding/forgot_binding.dart';
import 'package:green_pen/binding/login_binding.dart';
import 'package:green_pen/binding/register_binding.dart';
import 'package:green_pen/binding/reset_binding.dart';
import 'package:green_pen/screen/dashboard/dashboard.dart';
import 'package:green_pen/screen/login/forgot_password.dart';
import 'package:green_pen/screen/login/login_page.dart';
import 'package:green_pen/screen/login/otp.dart';
import 'package:green_pen/screen/login/register_page.dart';
import 'package:green_pen/screen/login/reset_password.dart';
import 'package:green_pen/screen/login/reset_success.dart';
import 'package:green_pen/utils/constant.dart';

/* date: 06.08.21
* name: vennila
* task: forgot_password (ForgetPasswordBinding added)*/
class AppPages {
  static final List<GetPage> pages = [
    //GetPage(name: ROUTE_SPLASH, page: () => SplashScreen()),
    GetPage(name: ROUTE_LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: ROUTE_OTP, page: () =>OtpScreen(name: 'login',)),
    GetPage(name: ROUTE_REGISTER, page: () =>const RegisterPage(), binding: RegisterBinding()),
    GetPage(name: ROUTE_FORGOT_PASSWORD, page: () => ForgotPasswordScreen(), binding: ForgotBinding()),
    GetPage(name: ROUTE_RESET_PASSWORD, page: () => ResetPasswordScreen(), binding: ResetBinding()),
    GetPage(name: ROUTE_RESET_SUCCESS, page: () =>ResetSuccessScreen()),
    GetPage(name: ROUTE_DASHBOARD, page: () =>DashBoard(),binding: DashboardBinding()),
  ];
}