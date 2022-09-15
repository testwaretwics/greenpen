// ignore_for_file: avoid_classes_with_only_static_members

import 'package:get/get.dart';
import 'package:green_pen/binding/about_purchased_test_binding.dart';
import 'package:green_pen/binding/booking_form_binding.dart';
import 'package:green_pen/binding/cart_binding.dart';
import 'package:green_pen/binding/dashboard_binding.dart';
import 'package:green_pen/binding/data_report_binding.dart';
import 'package:green_pen/binding/forgot_binding.dart';
import 'package:green_pen/binding/help_binding.dart';
import 'package:green_pen/binding/login_binding.dart';
import 'package:green_pen/binding/mark_analysis_binding.dart';
import 'package:green_pen/binding/notification_binding.dart';
import 'package:green_pen/binding/otp_binding.dart';
import 'package:green_pen/binding/privacy_policy_binding.dart';
import 'package:green_pen/binding/profile_binding.dart';
import 'package:green_pen/binding/purchased_tests_binding.dart';
import 'package:green_pen/binding/register_binding.dart';
import 'package:green_pen/binding/reset_binding.dart';
import 'package:green_pen/binding/term_and_conditions_binding.dart';
import 'package:green_pen/binding/test_details_binding.dart';
import 'package:green_pen/binding/test_instructions_binding.dart';
import 'package:green_pen/binding/test_report_binding.dart';
import 'package:green_pen/screen/Take%20Test/about_test_page.dart';
import 'package:green_pen/screen/assessments/test_detail.dart';
import 'package:green_pen/screen/assessments/unit_test_detail.dart';
import 'package:green_pen/screen/cart/about_test.dart';
import 'package:green_pen/screen/cart/booking_form.dart';
import 'package:green_pen/screen/cart/cart_page.dart';
import 'package:green_pen/screen/cart/test_syllabus.dart';
import 'package:green_pen/screen/dashboard/dashboard.dart';
import 'package:green_pen/screen/dashboard/profile_Info_page.dart';
import 'package:green_pen/screen/login/forgot_password.dart';
import 'package:green_pen/screen/login/login_page.dart';
import 'package:green_pen/screen/login/login_success.dart';
import 'package:green_pen/screen/login/otp.dart';
import 'package:green_pen/screen/login/register_page.dart';
import 'package:green_pen/screen/login/reset_password.dart';
import 'package:green_pen/screen/login/reset_success.dart';
import 'package:green_pen/screen/others/help.dart';
import 'package:green_pen/screen/others/notifications_detail_page.dart';
import 'package:green_pen/screen/others/notifications_page.dart';
import 'package:green_pen/screen/others/privacy_policy.dart';
import 'package:green_pen/screen/others/terms&cond.dart';
import 'package:green_pen/screen/result/data_report.dart';
import 'package:green_pen/screen/result/mark_analysis.dart';
import 'package:green_pen/screen/result/result_page.dart';
import 'package:green_pen/screen/test/test_instructions.dart';
import 'package:green_pen/screen/test/test_page.dart';
import 'package:green_pen/utils/constant.dart';

import '../screen/purchased test/about_test_page.dart';
import '../screen/purchased test/purchased_test_list.dart';

/* date: 06.08.21
* name: vennila
* task: forgot_password (ForgetPasswordBinding added)*/
class AppPages {
  static final List<GetPage> pages = [
    //GetPage(name: ROUTE_SPLASH, page: () => SplashScreen()),
    GetPage(
        name: ROUTE_LOGIN, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(
        name: ROUTE_OTP,
        page: () => OtpScreen(),binding: OtpBinding(),transition: Transition.circularReveal,),
    GetPage(
        name: ROUTE_REGISTER,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: ROUTE_FORGOT_PASSWORD,
        page: () => ForgotPasswordScreen(),
        binding: ForgotBinding()),
    GetPage(
        name: ROUTE_RESET_PASSWORD,
        page: () => ResetPasswordScreen(),
        binding: ResetBinding()),
    GetPage(name: ROUTE_RESET_SUCCESS, page: () => ResetSuccessScreen()),
    GetPage(name: ROUTE_LOGIN_SUCCESS, page: () => LoginSuccessScreen()),
    GetPage(
        name: ROUTE_DASHBOARD,
        page: () => Dashboard(),
        binding: DashboardBinding()),
    GetPage(
        name: ROUTE_PROFILE_INFO,
        page: () => ProfileInfo(),
        binding: ProfileBinding()),
    GetPage(name: ROUTE_HELP, page: () => HelpPage(), binding: HelpBinding()),
    GetPage(
        name: ROUTE_PRIVACY_POLICY,
        page: () => PrivacyPolicy(),
        binding: PrivacyPolicyBinding()),
    GetPage(
        name: ROUTE_TERM_AND_CONDITIONS,
        page: () => TermsAndConditions(),
        binding: TermAndConditionsBinding()),
    GetPage(
        name: ROUTE_NOTIFICATION,
        page: () => NotificationsPage(),
        binding: NotificationBinding()),
    GetPage(
        name: ROUTE_NOTIFICATION_READ,
        page: () => NotificationsDetailPage(),transitionDuration: Duration(milliseconds: 100),transition: Transition.noTransition),
    GetPage(
        name: ROUTE_TEST_DETAILS,
        page: () => TestDetail(),
        binding: TestDetailsBinding()),
    GetPage(name: ROUTE_UNIT_TEST_DETAILS, page: () => UnitTestDetail()),
    GetPage(name: ROUTE_ABOUT_TEST, page: () => AboutTest()),
    GetPage(name: ROUTE_TEST_PAGE, page: () => TestPage()),
    GetPage(name: ROUTE_CART, page: () => CartPage(), binding: CartBinding()),
    GetPage(name: ROUTE_BOOK_FORM, page: () => BookingForm(), binding: BookingFormBinding()),
    GetPage(name: ROUTE_TEST_INSTRUCTIONS, page: () => TestInstructions(), binding: TestInstructionsBinding()),

    GetPage(name: ROUTE_PURCHASED_TESTS, page: () =>PurchasedTests(), binding: PurchasedTestsBinding()),
    GetPage(name: ROUTE_ABOUT_PURCHASED_TESTS, page: () =>AboutPurchasedTest(), binding: AboutPurchasedTestBinding()),
    GetPage(name: ROUTE_TEST_REPORT, page: () =>TestReportPage(complete: true),binding: TestReportBinding()),
    GetPage(name: ROUTE_MARK_ANALYSIS, page: () =>MarkAnalysis(),binding: MarkAnalysisBinding()),
    GetPage(name: ROUTE_DATA_REPORT, page: () =>DataReports(),binding: DataReportBinding()),
    GetPage(name: ROUTE_TEST_SYLLABUS, page: () =>TestSyllabus()),
    GetPage(name: ROUTE_ABOUT_TEST_STATUS, page: () =>AboutTestStatus()),
  ];
}
