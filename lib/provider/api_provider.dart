import 'dart:convert';
import 'package:get/get.dart';
import 'package:green_pen/model/add_to_cart_model.dart';
import 'package:green_pen/model/booking_form_model.dart';
import 'package:green_pen/model/booking_model.dart';
import 'package:green_pen/model/buy_test_details_model.dart';
import 'package:green_pen/model/buy_test_filter_model.dart';
import 'package:green_pen/model/buy_test_model.dart';
import 'package:green_pen/model/cart_model.dart';
import 'package:green_pen/model/data_report_model.dart';
import 'package:green_pen/model/forgot_password_model.dart';
import 'package:green_pen/model/get_menus_model.dart';
import 'package:green_pen/model/help_model.dart';
import 'package:green_pen/model/home_model.dart';
import 'package:green_pen/model/log_out_model.dart';
import 'package:green_pen/model/login_model.dart';
import 'package:green_pen/model/mark_analysis_model.dart';
import 'package:green_pen/model/notification_clear_model.dart';
import 'package:green_pen/model/notification_model.dart';
import 'package:green_pen/model/notification_read_model.dart';
import 'package:green_pen/model/permanent_store_model.dart';
import 'package:green_pen/model/privacy_policy_model.dart';
import 'package:green_pen/model/profile_model.dart';
import 'package:green_pen/model/profile_update_model.dart';
import 'package:green_pen/model/purchased_test_details_model.dart';
import 'package:green_pen/model/purchased_tests_model.dart';
import 'package:green_pen/model/register_model.dart';
import 'package:green_pen/model/remove_to_cart_model.dart';
import 'package:green_pen/model/reset_model.dart';
import 'package:green_pen/model/take_test_detail_model.dart';
import 'package:green_pen/model/take_test_filter_model.dart';
import 'package:green_pen/model/take_test_model.dart';
import 'package:green_pen/model/temporary_store_model.dart';
import 'package:green_pen/model/terms_model.dart';
import 'package:green_pen/model/test_panel_model.dart';
import 'package:green_pen/model/test_report_model.dart';
import 'package:green_pen/model/test_result_model.dart';
import 'package:green_pen/model/test_time_table_model.dart';
import 'package:green_pen/model/timebased_report_model.dart';
import 'package:green_pen/service/api_service.dart';
import 'package:green_pen/utils/urlUtils.dart';
/* date: 06.08.21
* name: vennila
* task: forgot_password (forgotAPI and resetApi added)*/
class APIProvider {
  Future<void> loginAPI({
    var params,
    Function()? beforeSend,
    Function(LoginModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlLogin, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        LoginModel res = LoginModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> registerAPI({
    var params,
    Function()? beforeSend,
    Function(RegisterModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlRegister, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        RegisterModel res = RegisterModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)
      },
    );
  }

  Future<void> forgotAPI({
    var params,
    Function()? beforeSend,
    Function(ForgotPasswordModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlForgot, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ForgotPasswordModel res = ForgotPasswordModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> resetAPI({
    var params,
    Function()? beforeSend,
    Function(ResetPasswordModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlReset, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ResetPasswordModel res = ResetPasswordModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> homeAPI({
    var params,
    Function()? beforeSend,
    Function(HomeModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
  await ApiRequest(url: urlHome, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        HomeModel res = HomeModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> testTimeTableAPI({
    var params,
    Function()? beforeSend,
    Function(TestTimeTableModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlTestTimeTable, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TestTimeTableModel res = TestTimeTableModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> getMenusAPI({
    var params,
    Function()? beforeSend,
    Function(GetMenusModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlGetMenus, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        GetMenusModel res = GetMenusModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> profileAPI({
    var params,
    Function()? beforeSend,
    Function(ProfileModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlProfile, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ProfileModel res = ProfileModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> profileUpdateAPI({
    var params,
    Function()? beforeSend,
    Function(ProfileUpdateModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {

   await ApiRequest(url: urlProfileUpdate, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        ProfileUpdateModel res = ProfileUpdateModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> logoutAPI({
    var params,
    Function()? beforeSend,
    Function(LogOutModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlLogout, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        LogOutModel res = LogOutModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> takeTestAPI({
    var params,
    Function()? beforeSend,
    Function(TakeTestModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlTakeTest, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TakeTestModel res = TakeTestModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> takeTestFilterAPI({
    var params,
    Function()? beforeSend,
    Function(TakeTestFilterModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
  await ApiRequest(url: urlTakeTestFilter(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TakeTestFilterModel res = TakeTestFilterModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> takeTestDetailAPI({
    var params,
    Function()? beforeSend,
    Function(TakeTestDetailModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
   await ApiRequest(url: urlTakeTestDetail(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TakeTestDetailModel res = TakeTestDetailModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> notificationAPI({
    var params,
    Function()? beforeSend,
    Function(NotificationModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlNotification, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        NotificationModel res = NotificationModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> notificationReadAPI({
    var params,
    Function()? beforeSend,
    Function(NotificationReadModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
   await ApiRequest(url: urlNotificationRead(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        NotificationReadModel res = NotificationReadModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> notificationClearAPI({
    var params,
    Function()? beforeSend,
    Function(NotificationClearModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlNotificationClear, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        NotificationClearModel res = NotificationClearModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> buyTestAPI({
    var params,
    Function()? beforeSend,
    Function(BuyTestModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlBuyTest, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        BuyTestModel res = BuyTestModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> buyTestDetailsAPI({
    var params,
    Function()? beforeSend,
    Function(BuyTestDetailsModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
   await ApiRequest(url: urlBuyTestDetails(packageId: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        BuyTestDetailsModel res = BuyTestDetailsModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> buyTestFilterAPI({
    var params,
    Function()? beforeSend,
    Function(BuyTestFilterModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlBuyTestFilter, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        BuyTestFilterModel res = BuyTestFilterModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> bookingAPI({
    var params,
    Function()? beforeSend,
    Function(BookingModel data)? onSuccess,
    Function(dynamic error)? onError, id,
  }) async {
   await ApiRequest(url: urlBooking(packageId: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        BookingModel res = BookingModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> bookingFormAPI({
    var params,
    Function()? beforeSend,
    Function(BookingFormModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
   await ApiRequest(url: urlBookingForm, formdataParams: params).postWithData(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        BookingFormModel res = BookingFormModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> purchasedTestsAPI({
    var params,
    Function()? beforeSend,
    Function(PurchasedTestsModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlPurchasedTest, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        PurchasedTestsModel res = PurchasedTestsModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

 Future<void> purchasedTestDetailAPI({
    var params,
    Function()? beforeSend,
    Function(PurchasedTestDetailsModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
   await ApiRequest(url: urlPurchasedTestDetail(packageId: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        PurchasedTestDetailsModel res = PurchasedTestDetailsModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> cartAPI({
    var params,
    Function()? beforeSend,
    Function(CartModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlCart, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final CartModel res = CartModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> addToCartAPI({
    var params,
    Function()? beforeSend,
    Function(AddToCartModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlAddToCart, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final AddToCartModel res = AddToCartModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> removeToCartAPI({
    var params,
    Function()? beforeSend,
    Function(RemoveToCartModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlRemoveToCart, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final RemoveToCartModel res = RemoveToCartModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> testPanelAPI({
    var params,
    Function()? beforeSend,
    Function(TestPanelModel data)? onSuccess,
    Function(dynamic error)? onError, List? id,
  }) async {
    await ApiRequest(url: urlTestPanel(id![0],id[1]), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final TestPanelModel res = TestPanelModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> temporaryStoreAPI({
    var params,
    Function()? beforeSend,
    Function(TemporaryStoreModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlTemporaryStore, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final TemporaryStoreModel res = TemporaryStoreModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }


  Future<void> permanentStoreAPI({
    var params,
    Function()? beforeSend,
    Function(PermanentStoreModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlPermanentStore, params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        final PermanentStoreModel res = PermanentStoreModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> helpAPI({
    var params,
    Function()? beforeSend,
    Function(HelpModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlHelp, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        HelpModel res = HelpModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> privacyPolicyAPI({
    var params,
    Function()? beforeSend,
    Function(PrivacyPolicyModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlPrivacyPolicy, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        PrivacyPolicyModel res = PrivacyPolicyModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> termsAPI({
    var params,
    Function()? beforeSend,
    Function(TermsModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlTerms, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TermsModel res = TermsModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> testResultAPI({
    var params,
    Function()? beforeSend,
    Function(TestResultModel data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiRequest(url: urlTestResult, params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TestResultModel res = TestResultModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> testReportAPI({
    var params,
    Function()? beforeSend,
    Function(TestReportModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
    await ApiRequest(url: urlTestReport(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TestReportModel res = TestReportModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> markAnalysisAPI({
    var params,
    Function()? beforeSend,
    Function(MarkAnalysisModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
    await ApiRequest(url: urlMarkAnalysis(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        MarkAnalysisModel res = MarkAnalysisModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> dataReportAPI({
    var params,
    Function()? beforeSend,
    Function(DataReportModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
    await ApiRequest(url: urlDataReport(id: id), params: params).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        DataReportModel res = DataReportModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> timeBasedReportAPI({
    var params,
    Function()? beforeSend,
    Function(TimeBasedReportModel data)? onSuccess,
    Function(dynamic error)? onError, int? id,
  }) async {
    await ApiRequest(url: urlTimeBasedReport(id: id), params: params).postWithQuery(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        TimeBasedReportModel res = TimeBasedReportModel.fromJson(json.decode(data.toString()));
        onSuccess!(res);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

}





