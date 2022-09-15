
// const urlBase = 'https://admin.nnroll.in/api/';
const urlBase = 'https://demo.greenpen.in/api/';

/*LOGIN PAGE*/
const urlLogin = urlBase+'v1/login';
const urlRegister = urlBase+'v1/register';
const urlForgot = urlBase+'v1/forget_password';
const urlReset = urlBase+'v1/reset_password';
const urlHome = urlBase+'v1/dashboard';
const urlTestTimeTable = urlBase+'v1/dashboard-test-time-table';
const urlGetMenus = urlBase+'v1/get-menus';
const urlProfile = urlBase+'v1/profile';
const urlProfileUpdate = urlBase+'v1/profile-update';
const urlLogout = urlBase+'v1/logout';
const urlTakeTest = urlBase+'v1/take-test';
//const urlTakeTestFilter = urlBase+'v1/take-test-filter/2';
String urlTakeTestFilter({int? id}) => urlBase+'v1/notification-read/$id';
//const urlTakeTestDetail = urlBase+'v1/take-test-detail/4';
String urlTakeTestDetail({int? id}) => urlBase+'v1/take-test-detail/$id';
const urlNotification = urlBase+'v1/notification';
//const urlNotificationRead = urlBase+'v1/notification-read/1';
String urlNotificationRead({int? id}) => urlBase+'v1/notification-read/$id';
const urlNotificationClear = urlBase+'v1/notification-clear';
const urlBuyTest = urlBase+'v1/buy-test';
//const urlBuyTestDetails = urlBase+'v1/buy-test-detail/1';
String urlBuyTestDetails({int? packageId}) => urlBase+'v1/buy-test-detail/$packageId';
const urlBuyTestFilter = urlBase+'v1/buy-test?category_id=1';
//const urlBooking = urlBase+'v1/booking/{{package_id}}';
String urlBooking({int? packageId}) => urlBase+'v1/booking/$packageId';
const urlBookingForm = urlBase+'v1/bookingform';
const urlPurchasedTest = urlBase+'v1/purchased-test';
//const urlPurchasedTestDetail = urlBase+'v1/purchased-test-detail/{{package_id}}';
String urlPurchasedTestDetail({int? packageId}) => urlBase+'v1/purchased-test-detail/$packageId';
const String urlCart = urlBase+'v1/cart';
const String urlAddToCart = urlBase+'v1/add2cart';
const String urlRemoveToCart = urlBase+'v1/remove2cart';
//const String urlTestPanel = urlBase+'v1/test_panel/2/3';
String urlTestPanel(int? packageId,int? testId) => urlBase+'v1/test_panel/$packageId/$testId';
const String urlTemporaryStore = urlBase+'v1/temporary_store';
const String urlPermanentStore = urlBase+'v1/permanent_store';
const String urlHelp = urlBase+'v1/help';
const String urlPrivacyPolicy = urlBase+'v1/privacy_policy';
const String urlTerms = urlBase+'v1/terms';
const String urlTestResult = urlBase+'v1/result';
String urlTestReport({int? id}) => urlBase+'v1/report/$id';
String urlMarkAnalysis({int? id}) => urlBase+'v1/mark-analysis/$id';
String urlDataReport({int? id}) => urlBase+'v1/data-report/$id';
String urlTimeBasedReport({int? id}) => urlBase+'v1/timebased-report/$id';


