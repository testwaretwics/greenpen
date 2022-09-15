// ignore_for_file: must_be_immutable

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/buy_test_controller.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/dashboard_controller.dart';
import 'package:green_pen/controller/get_menus_controller.dart';
import 'package:green_pen/controller/home_controller.dart';
import 'package:green_pen/controller/logout_controller.dart';
import 'package:green_pen/controller/profile_controller.dart';
import 'package:green_pen/controller/take_test_controller.dart';
import 'package:green_pen/controller/test_result_controller.dart';
import 'package:green_pen/screen/Take%20Test/take_test.dart';
import 'package:green_pen/screen/cart/buy_test.dart';
import 'package:green_pen/screen/home/home_page.dart';
import 'package:green_pen/screen/result/list_test_result.dart';
import 'package:green_pen/service/network_info.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/image_contants.dart';
import 'package:green_pen/utils/preferences.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';
import 'package:green_pen/utils/text_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var dashboardController = Get.put(DashboardController());

  var homeController = Get.put(HomeController());

  var profileController = Get.put(ProfileController());

  var logoutController = Get.put(LogoutController());

  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  var currentBackPressTime;

  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();




  @override
  void initState() {
    NetworkInfo.checkConnectivity(scaffoldKey);
    print(
        "Get Pref Value : ${Preferences.getBoolValuesSF(Preferences.USER_SHOW_CASE_WIDGET)}");
    if (Preferences.getBoolValuesSF(Preferences.USER_SHOW_CASE_WIDGET) ==
            false ||
        Preferences.getBoolValuesSF(Preferences.USER_SHOW_CASE_WIDGET) ==
            null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context)!.startShowCase([_one, _two, _three]));
    }


    /// This method call when app is working in application to open from.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print("notification1111 ${notification!.body}");
      print("message1111 2222 ${message.data['click_action'].toString().split(" ").last}");
    });


    /// This method call when app is working in background.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // AppleNotification? ios = message.notification?.apple;
      print("notifications6666 12 $notification");
      if (notification != null ) {
        print("notifications6666 13 $notification}");
      }
    });


    /// This method call when app is killed(Terminated).
    // killAppNotification();
    killAppNotificationFunction();

    super.initState();
  }

  /// Kill(Terminated) app function.
killAppNotificationFunction() async {
  RemoteMessage? terminatedMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (terminatedMessage != null) {
    // this is a function I created to route to a page
    processKillAppPushNotification(message: terminatedMessage);
  }
}

void processKillAppPushNotification({RemoteMessage? message}) async {
  print("message data ${message!.data}");

  RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  if (notification != null) {
    print("notification Data");
  }
}

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > Duration(milliseconds: 700)) {
        currentBackPressTime = now;
        if (dashboardController.selectedIndex != 0) {
          dashboardController.selectedIndex = 0;
          dashboardController.update();
        } else {
          Get.snackbar('Exit', 'Press back again to exit app',
              backgroundColor: Colors.black45, colorText: Colors.white);
        }
        return Future.value(false);
      }
      return Future.value(true);
    }

    List<BottomNavigationBarItem> itemBar = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: GetBuilder<DashboardController>(
              builder: (DashboardController dashboardController) {
            return Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(homeIconImage,
                        height: size20,
                        width: size22,
                        color: dashboardController.selectedIndex == 0
                            ? kBlue1Color
                            : kGreyColor),
                    SizedBox(
                      height: size5,
                    ),
                    Text(
                      homeText,
                      style: TextStyle(fontSize: 13),
                    ),
                    if (dashboardController.selectedIndex == 0)
                      Container(
                        height: size6,
                        width: size6,
                        margin: EdgeInsets.only(top: size7),
                        decoration: const BoxDecoration(
                            color: kBlue1Color, shape: BoxShape.circle),
                      )
                    else
                      const SizedBox.shrink()
                  ],
                ));
          }),
          label: ''),
      BottomNavigationBarItem(
          icon: GetBuilder<DashboardController>(
              builder: (DashboardController dashboardController) {
            return Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart,
                            size: size25,
                            color: dashboardController.selectedIndex == 1
                                ? kBlue1Color
                                : kGreyColor),
                        Text(
                          cartText,
                          style: TextStyle(fontSize: 13),
                        ),
                        if (dashboardController.selectedIndex == 1)
                          Container(
                            height: size6,
                            width: size6,
                            margin: EdgeInsets.only(top: size7),
                            decoration: const BoxDecoration(
                                color: kBlue1Color, shape: BoxShape.circle),
                          )
                        else
                          const SizedBox.shrink()
                      ],
                    ),
                    GetBuilder<CartController>(builder: (cartController) {
                      return cartController.cartDataList.isNotEmpty
                          ? Container(
                              height: size15,
                              width: size15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: primaryColor),
                              child: Center(
                                child: Text(
                                  cartController.cartDataList.length.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    }),
                  ],
                ));
          }),
          label: ''),
      BottomNavigationBarItem(
          icon: GetBuilder<DashboardController>(
              builder: (DashboardController dashboardController) {
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pie_chart,
                      size: size25,
                      color: dashboardController.selectedIndex == 2
                          ? kBlue1Color
                          : kGreyColor),
                  Text(
                    resultsText,
                    style: TextStyle(fontSize: 13),
                  ),
                  if (dashboardController.selectedIndex == 2)
                    Container(
                      height: size6,
                      width: size6,
                      margin: EdgeInsets.only(top: size7),
                      decoration: const BoxDecoration(
                          color: kBlue1Color, shape: BoxShape.circle),
                    )
                  else
                    const SizedBox.shrink()
                ],
              ),
            );
          }),
          label: ''),
      BottomNavigationBarItem(
          icon: GetBuilder<DashboardController>(
              builder: (DashboardController dashboardController) {
            return Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(editNoteIconImage,
                      height: size22,
                      width: size22,
                      color: dashboardController.selectedIndex == 3
                          ? kBlue1Color
                          : kGreyColor),
                  Text(
                    takeTestText,
                    style: TextStyle(fontSize: 13),
                  ),
                  if (dashboardController.selectedIndex == 3)
                    Container(
                      height: size6,
                      width: size6,
                      margin: EdgeInsets.only(top: size7),
                      decoration: const BoxDecoration(
                          color: kBlue1Color, shape: BoxShape.circle),
                    )
                  else
                    const SizedBox.shrink()
                ],
              ),
            );
          }),
          label: ''),
    ];

    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Theme(
          data: ThemeData(
              primaryIconTheme: const IconThemeData(color: Colors.black)),
          child: Scaffold(
            body: GetBuilder<DashboardController>(
                builder: (DashboardController dashboardController) {
              return Scaffold(
                key: scaffoldKey,
                appBar: dashboardController.selectedIndex == 0
                    ? PreferredSize(
                        preferredSize: Size(double.infinity, size80),
                        child: Padding(
                          padding: EdgeInsets.only(top: size10),
                          child: AppBar(
                            leading: Builder(
                              builder:
                                  (context) => // Ensure Scaffold is in context
                                      Preferences.getBoolValuesSF(Preferences
                                                      .USER_SHOW_CASE_WIDGET) ==
                                                  false ||
                                              Preferences.getBoolValuesSF(
                                                      Preferences
                                                          .USER_SHOW_CASE_WIDGET) ==
                                                  null
                                          ? Showcase(
                                              key: _one,
                                              title: menuText,
                                              overlayOpacity: 0.2,
                                              description:
                                                  'Click here to see menu options',
                                              child: IconButton(
                                                //padding: EdgeInsets.only(left: 15),
                                                icon: Image.asset(
                                                    menuIconImage,
                                                    height: size28),
                                                onPressed: () {
                                                  Scaffold.of(context)
                                                      .openDrawer();
                                                  // getMenusController.getMenusApiData();
                                                },
                                              ),
                                            )
                                          : IconButton(
                                              icon: Image.asset(
                                                  menuIconImage,
                                                  height: size28),
                                              onPressed: () {
                                                Scaffold.of(context)
                                                    .openDrawer();
                                              },
                                            ),
                            ),
                            actions: [
                              Padding(
                                padding: EdgeInsets.only(top: size7, right: size15),
                                child: Preferences.getBoolValuesSF(Preferences
                                                .USER_SHOW_CASE_WIDGET) ==
                                            false ||
                                        Preferences.getBoolValuesSF(Preferences
                                                .USER_SHOW_CASE_WIDGET) ==
                                            null
                                    ? Showcase(
                                        key: _two,
                                        title: notificationText,
                                        overlayOpacity: 0.2,
                                        description:
                                            'Click here to see notifications',
                                        child: Stack(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Get.toNamed(ROUTE_NOTIFICATION);
                                              },
                                              icon: Icon(
                                                Icons.notifications,
                                                color: Colors.black,
                                                size: size30,
                                              ),
                                            ),
                                            Positioned(
                                              right: size13,
                                              top: size9,
                                              child: Container(
                                                height: size8,
                                                width: size8,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xff1CBBA3),
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Stack(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Get.toNamed(ROUTE_NOTIFICATION);
                                            },
                                            icon: Icon(
                                              Icons.notifications,
                                              color: Colors.black,
                                              size: size30,
                                            ),
                                          ),
                                          Positioned(
                                            right: size13,
                                            top: size9,
                                            child: Container(
                                              height: size8,
                                              width: size8,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xff1CBBA3),
                                                  shape: BoxShape.circle),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              GetBuilder<HomeController>(
                                  init: homeController,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: size10),
                                      child: Preferences.getBoolValuesSF(Preferences
                                                      .USER_SHOW_CASE_WIDGET) ==
                                                  false ||
                                              Preferences.getBoolValuesSF(
                                                      Preferences
                                                          .USER_SHOW_CASE_WIDGET) ==
                                                  null
                                          ? Showcase(
                                              key: _three,
                                              title: profileText,
                                              overlayOpacity: 0.2,
                                              radius: BorderRadius.circular(size50),
                                              description:
                                                  'Click here to see profile',
                                              child: InkWell(
                                                onTap: () async {
                                                  Get.toNamed(
                                                      ROUTE_PROFILE_INFO);
                                                },
                                                child:
                                                homeController.homeDataList
                                                    .isNotEmpty
                                                    ?
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                     homeController
                                                            .userImage.value
                                                  ),
                                                ) : Center(child: CircularProgressIndicator()),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                Get.toNamed(ROUTE_PROFILE_INFO);
                                              },
                                              child:  homeController.homeDataList
                                                  .isNotEmpty ?
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                  homeController.homeDataList
                                                          .isNotEmpty
                                                      ? homeController
                                                          .userImage.value
                                                      : 'https://data.whicdn.com/images/322027365/original.jpg?t=1541703413',
                                                ),
                                              ) :
                                              CircleAvatar(
                                                radius: 20,
                                                child: Icon(Icons.person, size: 32),
                                              ),
                                            ),
                                    );
                                  })
                            ],
                            centerTitle: true,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      )
                    : null,
                //key: _drawerKey,
                drawer: dashboardController.selectedIndex == 0
                    ? drawerMenu()
                    : null,
                body: IndexedStack(
                  index: dashboardController.selectedIndex,
                  children: [
                    HomePage(),
                    BuyTestPage(),
                    ResultListsPage(),
                    TakeTestPage()
                  ],
                ),
                bottomNavigationBar: GetBuilder<DashboardController>(
                    builder: (DashboardController dashboardController) {
                  return BottomNavigationBar(
                    items: itemBar,
                    selectedFontSize: 0,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: dashboardController.selectedIndex,
                    onTap: (index) {
                      setState(() {
                        dashboardController.selectedIndex = index;

                        if (Preferences.getBoolValuesSF(
                                    Preferences.USER_SHOW_CASE_WIDGET) ==
                                false ||
                            Preferences.getBoolValuesSF(
                                    Preferences.USER_SHOW_CASE_WIDGET) ==
                                null) {
                          if (dashboardController.selectedIndex == 1) {
                            if (dashboardController.showCaseOne == false) {
                              WidgetsBinding.instance!.addPostFrameCallback(
                                  (_) => ShowCaseWidget.of(context)!
                                          .startShowCase([
                                        Get.put(BuyTestController()).four,
                                        Get.put(BuyTestController()).five,
                                        Get.put(BuyTestController()).six,
                                        Get.put(BuyTestController()).seven,
                                      ]));
                              dashboardController.showCaseOne = true;
                            }
                          } else if (dashboardController.selectedIndex == 2) {
                            if (dashboardController.showCaseTwo == false) {
                              WidgetsBinding.instance!.addPostFrameCallback(
                                  (_) => ShowCaseWidget.of(context)!
                                          .startShowCase([
                                        Get.put(TestResultController()).eight,
                                        Get.put(TestResultController()).nine,
                                      ]));
                              dashboardController.showCaseTwo = true;
                            }
                          } else if (dashboardController.selectedIndex == 3) {
                            if (dashboardController.showCaseThree == false) {
                              WidgetsBinding.instance!.addPostFrameCallback(
                                  (_) => ShowCaseWidget.of(context)!
                                      .startShowCase([Get.put(TakeTestController()).ten]));
                              dashboardController.showCaseThree = true;
                            }
                          } else {
                            if (dashboardController.showCaseOne == true &&
                                dashboardController.showCaseTwo == true &&
                                dashboardController.showCaseThree == true) {
                              print("Yes");
                              Preferences.addDataToSF(
                                  Preferences.USER_SHOW_CASE_WIDGET, true);
                            }
                          }
                        }
                        dashboardController.update();
                      });
                    },
                  );
                }),
              );
            }),
          )),
    );
  }

  Drawer drawerMenu() {
    return Drawer(child: GetBuilder<GetMenusController>(
      builder: (getMenusController) {
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size206,
                  width: double.infinity,
                  color: secondaryColor,
                  child: Padding(
                    padding: EdgeInsets.only(left: size23, bottom: size22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getMenusController.userName,
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: size16,
                              fontWeight: TextUtils.titleTextWeight,
                              fontFamily: TextUtils.interFontFamily),
                        ),
                        SizedBox(
                          height: size5,
                        ),
                        Text(
                          "+91 ${getMenusController.userMobile}",
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: size14,
                              fontWeight: TextUtils.normalTextWeight,
                              fontFamily: TextUtils.interFontFamily),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: getMenusController.getMenusDataList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            if (index == 0) {
                              Get.back();
                              Get.toNamed(ROUTE_PROFILE_INFO);
                            } else if (index == 1) {
                              Get.back();
                              dashboardController.selectedIndex = 3;
                              dashboardController.update();
                            } else if (index == 2) {
                              Get.back();
                              Get.toNamed(ROUTE_PURCHASED_TESTS);
                            } else if (index == 3) {
                              Get.back();
                              Get.toNamed(ROUTE_TERM_AND_CONDITIONS);
                            } else if (index == 4) {
                              Get.back();
                              Get.toNamed(ROUTE_PRIVACY_POLICY);
                            } else if (index == 5) {
                              Get.back();
                              Get.toNamed(ROUTE_HELP);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size13, vertical: size13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  getMenusController.getMenusDataList[index],
                                  style: TextStyle(
                                      fontSize: size14,
                                      fontWeight: TextUtils.mediumtTextWeight,
                                      fontFamily: TextUtils.interFontFamily),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                InkWell(
                  onTap: () async {
                    Get.back();
                    await logoutController.getLogoutApiData();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size21, top: size27, bottom: size30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: size10),
                          child: Image.asset(
                            signOutIconImage,
                            color: secondaryColor,
                            height: size20,
                            width: size20,
                          ),
                        ),
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: size14,
                            fontWeight: TextUtils.mediumtTextWeight,
                            fontFamily: TextUtils.interFontFamily,
                            color: secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: size60,
              left: size23,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  getMenusController.userImage,
                ),
              ),
            ),
            Positioned(
              top: size75,
              right: size27,
              child: Container(
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close_outlined,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
