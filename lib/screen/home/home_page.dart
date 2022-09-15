// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/buy_test_controller.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/dashboard_controller.dart';
import 'package:green_pen/controller/get_menus_controller.dart';
import 'package:green_pen/controller/home_controller.dart';
import 'package:green_pen/controller/take_test_controller.dart';
import 'package:green_pen/controller/test_report_controller.dart';
import 'package:green_pen/controller/test_result_controller.dart';
import 'package:green_pen/model/home_model.dart';
import 'package:green_pen/model/test_time_table_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/image_contants.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';
import 'package:green_pen/utils/text_utils.dart';
import 'package:intl/intl.dart';
import 'package:new_version/new_version.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeController = Get.put(HomeController());
  var dashboardController = Get.put(DashboardController());
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  CarouselController carouselController = CarouselController();
  int carouselIndex = 0;

  // RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      await homeController.getAPICalled();
      await Get.put(GetMenusController()).getMenusApiData();
    } else {
      Get.snackbar('Internet', 'No Internet Connection',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    dashboardController.refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    dashboardController.refreshController.loadComplete();
  }

  var newVersion;
  var status;

  @override
  void initState() {
    super.initState();
    homeController.getAPICalled();
  }

  getVersion() async {
    newVersion = NewVersion(
        androidId: 'com.snapchat.android', iOSId: 'com.example.greenPen');
    status = await newVersion.getVersionStatus();
    print("Local : ${status!.localVersion}");
    print("Store : ${status.storeVersion}");

    if (status.localVersion != status.storeVersion) {
      _checkVersion();
    }
  }

  _checkVersion() async {
    newVersion.showUpdateDialog(
        context: context,
        versionStatus: status!,
        dialogTitle: 'Update!!',
        dismissButtonText: 'Skip',
        dialogText:
            'Please update the app from ${status.localVersion} to ${status.storeVersion}',
        dismissAction: () {
          Get.back();
        },
        updateButtonText: "Let's update");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => homeController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                color: Colors.white,
                strokeWidth: 1.5,
              ))
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: dashboardController.refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size15, right: size15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(hiText,
                                  style: TextStyle(
                                      fontSize: size18,
                                      fontFamily: TextUtils.interFontFamily)),
                              Text(
                                homeController.homeDataList.isNotEmpty
                                    ? homeController.userName.value
                                    : '${homeController.homeDataList.length}',
                                style: TextStyle(
                                    fontSize: size18,
                                    fontWeight: TextUtils.headerTextWeight,
                                    fontFamily: TextUtils.interFontFamily),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size10,
                          ),
                          Row(
                            children: [
                              Text(lastLoginText,
                                  style: TextStyle(
                                      fontSize: size14,
                                      fontWeight: TextUtils.normalTextWeight,
                                      fontFamily: TextUtils.interFontFamily)),
                              Text(
                                homeController.homeDataList.isNotEmpty
                                    ? homeController.userLastLogin.value
                                    : '',
                                style: TextStyle(
                                    color: kBlueColor, //Color(0xff296ACC),
                                    fontSize: size12,
                                    fontFamily: TextUtils.interFontFamily,
                                    fontWeight: TextUtils.mediumtTextWeight),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size15,
                          ),
                          Divider(
                            thickness: 0.9,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          SizedBox(
                            height: size10,
                          ),
                          homeController.rankScoredRecentlyDataList.isEmpty
                              ? homeRankedCard()
                              : Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CarouselSlider.builder(
                                      carouselController: carouselController,
                                      options: CarouselOptions(
                                          scrollDirection: Axis.horizontal,
                                          enlargeCenterPage: true,
                                          viewportFraction: 1,
                                          initialPage: 0,
                                          autoPlay: true,
                                          onPageChanged: (index, page) {
                                            setState(() {
                                              carouselIndex = index;
                                            });
                                          },
                                          autoPlayAnimationDuration:
                                              const Duration(seconds: 1)),
                                      itemCount: homeController
                                          .rankScoredRecentlyDataList.length,
                                      itemBuilder: (context, index, realIdx) {
                                        return homeRankedCardWithData(
                                            homeController
                                                    .rankScoredRecentlyDataList[
                                                index],
                                            index);
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: size20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: List.generate(
                                            homeController
                                                .rankScoredRecentlyDataList
                                                .length,
                                            (index) => Container(
                                                  height: size7,
                                                  width: size7,
                                                  margin: EdgeInsets.only(
                                                      bottom: size10,
                                                      left: size3,
                                                      right: size3),
                                                  decoration: BoxDecoration(
                                                      color: carouselIndex ==
                                                              index
                                                          ? primaryColor
                                                          : carouselIndex ==
                                                                  index
                                                              ? primaryColor
                                                              : carouselIndex ==
                                                                      index
                                                                  ? primaryColor
                                                                  : kGreyColor
                                                                      .withOpacity(
                                                                          0.5),
                                                      shape: BoxShape.circle),
                                                )),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: size16,
                          ),
                          Text(
                            summaryForTestsText,
                            style: TextStyle(
                                fontSize: size16,
                                fontWeight: TextUtils.headerTextWeight,
                                fontFamily: TextUtils.interFontFamily),
                          ),
                          SizedBox(
                            height: size18,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gridChildren(
                                  testIncompleteIconImage,
                                  const Color(0xff0B6B31),
                                  testsIncompleteText,
                                  homeController
                                      .summaryForTestDataList.incompletedTest
                                      .toString()),
                              SizedBox(width: 5),
                              gridChildren(
                                  testCompletedIconImage,
                                  const Color(0xffA6B800),
                                  testCompletedText,
                                  homeController
                                      .summaryForTestDataList.completedTest
                                      .toString()),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gridChildren(
                                  testPendingIconImage,
                                  const Color(0xff200038),
                                  testPendingText,
                                  homeController
                                      .summaryForTestDataList.pendingTest
                                      .toString()),
                              SizedBox(width: 5),
                              gridChildren(
                                  testPercentageIconImage,
                                  const Color(0xff6B0556),
                                  testPercentageText,
                                  '${homeController.summaryForTestDataList.percentage.toString()}%'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size23,
                    ),
                    Container(
                      height: size48,
                      color: const Color(0xffE4EDFF),
                      child: Padding(
                        padding: EdgeInsets.only(left: size24, right: size24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              testTimetableText,
                              style: TextStyle(
                                  fontSize: size16,
                                  fontWeight: TextUtils.headerTextWeight,
                                  fontFamily: TextUtils.interFontFamily),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat('dd-MMM-yyyy')
                                        .format(homeController.selectedDate),
                                    style: TextStyle(
                                      fontSize: size12,
                                      fontWeight: TextUtils.mediumtTextWeight,
                                      fontFamily: TextUtils.interFontFamily,
                                      color: kBlueColor,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                            // Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                    homeController.testTimeTableDataList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: size48),
                            child: Column(
                              children: [
                                Image.asset(
                                  emptyTestTimeTableIconImage,
                                  height: size149,
                                ),
                                SizedBox(
                                  height: size41,
                                ),
                                Text(
                                  noTestsScheduledText,
                                  style: TextStyle(
                                    fontSize: size14,
                                    fontWeight: TextUtils.titleTextWeight,
                                    fontFamily: TextUtils.interFontFamily,
                                    color: kGreyColor,
                                  ),
                                ),
                                SizedBox(
                                  height: size41,
                                ),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              homeController.testTimeTableDataList.isNotEmpty &&
                                      homeController
                                              .testTimeTableDataList.length ==
                                          1
                                  ? Container()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          bottom: size10, left: size20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: size12,
                                            width: size12,
                                            decoration: BoxDecoration(
                                              color: kPinkBtnColor,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: kWhiteColor,
                                                  width: 1.5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(0.0, 3),
                                                    blurRadius: 3,
                                                    spreadRadius: 0.2),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: size70,
                                            child: DottedLine(
                                              direction: Axis.vertical,
                                              lineLength: double.infinity,
                                              lineThickness: 1.0,
                                              dashLength: 4.0,
                                              dashColor: Colors.grey,
                                              dashRadius: 0.0,
                                              dashGapLength: 4.0,
                                              dashGapRadius: 0.0,
                                            ),
                                          ),
                                          Container(
                                            height: size12,
                                            width: size12,
                                            decoration: BoxDecoration(
                                              color: Colors.greenAccent
                                                  .withOpacity(0.5),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: kWhiteColor,
                                                  width: 1.5),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    offset:
                                                        const Offset(0.0, 3),
                                                    blurRadius: 3,
                                                    spreadRadius: 0.2),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: homeController
                                        .testTimeTableDataList.length,
                                    primary: true,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return testListWidget(homeController
                                          .testTimeTableDataList[index]);
                                    }),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget testListWidget(TestTimeTable data) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size8, right: size8, left: size8),
      width: size.width - size40,
      child: ListTile(
        title: Text(
          data.testTitle.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: size14,
              fontWeight: TextUtils.titleTextWeight,
              fontFamily: TextUtils.interFontFamily),
        ),
        subtitle: Row(
          children: [
            Image.asset(
              descriptiveIconImage,
              height: size15,
            ),
            SizedBox(
              width: size5,
            ),
            Text(
              data.examType.toString(),
              style: TextStyle(
                  fontSize: size12,
                  fontWeight: TextUtils.normalTextWeight,
                  fontFamily: TextUtils.interFontFamily),
            ),
            SizedBox(
              width: size13,
            ),
            Image.asset(
              carbonTimeImage,
              height: size15,
            ),
            SizedBox(
              width: size5,
            ),
            Text(
              data.testTime.toString(),
              style: TextStyle(
                  fontSize: size12,
                  fontWeight: TextUtils.normalTextWeight,
                  fontFamily: TextUtils.interFontFamily),
            ),
            const Spacer(),
            data.testStatus == 2
                ? InkWell(
                    onTap: () {
                      setState(() {
                        Get.put(DashboardController()).selectedIndex = 2;
                        Get.put(DashboardController()).update();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5, bottom: 2),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: size32,
                      width: size100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            viewResultText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size12,
                                fontWeight: TextUtils.normalTextWeight,
                                fontFamily: TextUtils.interFontFamily),
                          ),
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      var result = await (Connectivity().checkConnectivity());
                      if (result == ConnectivityResult.wifi ||
                          result == ConnectivityResult.mobile) {
                        Get.toNamed(ROUTE_TEST_INSTRUCTIONS,
                            arguments: [data.packageId, data.testId]);
                      } else {
                        Get.snackbar('Internet', 'No Internet Connection',
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: size5, bottom: size2),
                      decoration: BoxDecoration(
                        color: const Color(0xff1CBBA3),
                        borderRadius: BorderRadius.circular(size5),
                      ),
                      height: size32,
                      width: size100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            takeTestText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size12,
                                fontWeight: TextUtils.normalTextWeight,
                                fontFamily: TextUtils.interFontFamily),
                          ),
                          Image.asset(rightArrowCircleImage, height: size22),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget homeRankedCard() {
    return Container(
      margin: EdgeInsets.all(size2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0.0, 2),
              blurRadius: 5,
              spreadRadius: 0.5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            //width: size200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size13, top: size32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(rankedScroreImage,
                          height: size20, width: size14),
                      SizedBox(
                        width: size9,
                      ),
                      Container(
                        width: size158,
                        child: Text(
                          ranksScoredRecentlyText,
                          style: TextStyle(
                              fontSize: size14,
                              fontWeight: TextUtils.headerTextWeight,
                              fontFamily: TextUtils.interFontFamily),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: size13, top: size20),
                  width: size158,
                  child: Text(
                    testAndPractiseText,
                    style: TextStyle(
                        fontSize: size12,
                        fontWeight: TextUtils.mediumtTextWeight,
                        fontFamily: TextUtils.interFontFamily),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size13, top: size18, bottom: size21),
                  child: InkWell(
                    onTap: () {
                      Get.put(DashboardController()).selectedIndex = 1;
                      Get.put(DashboardController()).update();
                      //Get.toNamed(ROUTE_TEST_INSTRUCTIONS, arguments: [2, 2]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff1CBBA3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: size32,
                      width: size100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            takeTestText,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size12,
                                fontWeight: TextUtils.normalTextWeight,
                                fontFamily: TextUtils.interFontFamily),
                          ),
                          Container(
                            height: size13,
                            width: size13,
                            decoration: BoxDecoration(
                              border: Border.all(color: kWhiteColor),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(arrowRightImage,
                                height: size5, width: size5),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          //Spacer(),
          Image.asset(
            signupIconLogoImage,
            height: size158,
            width: size100,
          )
        ],
      ),
    );
  }

  Widget homeRankedCardWithData(RankScoredRecently data, int index) {
    return Container(
      margin: EdgeInsets.all(size2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0.0, 2),
              blurRadius: 5,
              spreadRadius: 0.5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size13, top: size10),
                  child: Container(
                    width: size158,
                    child: Text(
                      ranksScoredRecentlyText,
                      style: TextStyle(
                          fontSize: size14,
                          fontWeight: TextUtils.headerTextWeight,
                          fontFamily: TextUtils.interFontFamily),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size13),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        rankedScroreImage,
                        height: size20,
                        width: size14,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: size9,
                      ),
                      Container(
                        width: size158,
                        child: Text(
                          data.title.toString(),
                          style: TextStyle(
                              fontSize: size12,
                              fontWeight: TextUtils.mediumtTextWeight,
                              fontFamily: TextUtils.interFontFamily),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size35),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: rankText,
                      style: TextStyle(
                          fontSize: size14,
                          fontWeight: TextUtils.mediumtTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: data.rank,
                      style: TextStyle(
                          fontSize: size14,
                          fontWeight: TextUtils.mediumtTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                          color: primaryColor),
                    )
                  ])),
                ),
                Padding(
                  padding: EdgeInsets.only(left: size35),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: markScoredText,
                      style: TextStyle(
                          fontSize: size14,
                          fontWeight: TextUtils.mediumtTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: "${data.mark}/${data.totalMark}",
                      style: TextStyle(
                          fontSize: size14,
                          fontWeight: TextUtils.mediumtTextWeight,
                          fontFamily: TextUtils.interFontFamily,
                          color: primaryColor),
                    )
                  ])),
                ),
              ],
            ),
          ),
          //Spacer(),
          Padding(
            padding: EdgeInsets.only(right: size5),
            child: Image.asset(
              signupIconLogoImage,
              height: size158,
              width: size90,
            ),
          )
        ],
      ),
    );
  }

  Widget gridChildren(image, Color color, String title, String count) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: size5, bottom: size5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size5),
          border: Border.all(
            color: const Color(0xffBCE4FB),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size13, left: size10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size36,
                    width: size36,
                    decoration:
                        BoxDecoration(color: color, shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset(
                        image,
                        color: Colors.white,
                        height: size20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size10,
                  ),
                  Container(
                    width: size78,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: size14,
                          fontWeight: TextUtils.mediumtTextWeight,
                          fontFamily: TextUtils.interFontFamily),
                    ),
                  ),
                  SizedBox(
                    width: size5,
                  ),
                ],
              ),
            ),
            SizedBox(height: size10),
            Padding(
              padding: EdgeInsets.only(right: size10),
              child: Text(
                count,
                style: TextStyle(
                    fontSize: size20,
                    fontWeight: TextUtils.titleTextWeight,
                    fontFamily: TextUtils.interFontFamily),
              ),
            ),
            SizedBox(height: size12),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: homeController.selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: Container(
            child: child,
          ),
        );
      },
    );
    if (picked != null && picked != homeController.selectedDate) {
      setState(() {
        homeController.selectedDate = picked;
      });
      var result = await (Connectivity().checkConnectivity());
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        homeController.getTestTimeTableApiData(
            homeController.selectedDate.toString().split(" ").first);
      } else {
        Get.snackbar('Internet', 'No Internet Connection',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  /// This builds cupertino date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: size10),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      doneText,
                      style: TextStyle(
                          fontWeight: TextUtils.normalTextWeight,
                          fontSize:
                              TextUtils.hintTextSize / Get.textScaleFactor,
                          fontFamily: TextUtils.interFontFamily,
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[300],
                      minimumSize: Size(size70, size30),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (picked) {
                        if (picked != homeController.selectedDate) {
                          setState(() {
                            homeController.selectedDate = picked;
                          });
                        }
                      },
                      minimumYear: 1950,
                      maximumYear: 2100),
                ),
              ],
            ),
          );
        });
  }
}

class GridVal {
  final IconData icon;
  final Color color;
  final String title;
  final String count;

  GridVal(this.icon, this.color, this.title, this.count);
}
