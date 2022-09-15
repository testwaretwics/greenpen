// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/test_result_controller.dart';
import 'package:green_pen/model/test_result_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';

class ResultListsPage extends StatefulWidget {
  @override
  State<ResultListsPage> createState() => _ResultListsPageState();
}

class _ResultListsPageState extends State<ResultListsPage> {
  final testResultController = Get.put(TestResultController());


  var refreshKey = GlobalKey();

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await Get.put(TestResultController()).getTestResultApiData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    testResultController.apiCallingMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: GlobalKey(),
      appBar: AppBar(
        title: Text("Test Results"),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Obx(
        () => testResultController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                Showcase(
                  key: testResultController.eight,
                  title: 'Category',
                  overlayOpacity: 0.2,
                  description: 'List of categories',
                  radius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30)),
                  child: CustomRadioButton(
                    defaultSelected: testResultController.tabCategoryId,
                    unSelectedBorderColor: Colors.grey.shade200,
                    selectedBorderColor: Colors.grey.shade200,
                    enableShape: true,
                    padding: 12,
                    spacing: 5,
                    elevation: 0,
                    absoluteZeroSpacing: false,
                    unSelectedColor: Theme.of(context).canvasColor,
                    buttonLables: List.generate(
                        testResultController.categoryDataList.length,
                        (index) => testResultController
                            .categoryDataList[index].courseCategoryLang1!),
                    buttonValues: List.generate(
                        testResultController.categoryDataList.length,
                        (index) => testResultController
                            .categoryDataList[index].id!),
                    buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Color(0xffB5B5B5),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    radioButtonValue: (value) {
                      testResultController.tabCategoryId = value;
                      testResultController
                          .getCategoryWithTestResultDataList(value);
                    },
                    selectedColor: Color(0xff80B2FF),
                  ),
                ),
                SizedBox(height: 15),
                testResultController.categoryWithTestResultDataList.isEmpty
                    ? Container(
                        height: size.height / 1.5,
                        alignment: AlignmentDirectional.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/png_file/no_data.png',
                                height: 153, width: 148),
                            const SizedBox(height: 15),
                            const Text(
                              'No Tests Scheduled',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'We will notify you once you get your \ntests scheduled.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                      child: SmartRefresher(
                        key: refreshKey,
                          controller: _refreshController,//dashboardController.refreshController,
                          onRefresh: _onRefresh,
                          onLoading: _onLoading,
                        child: ListView.builder(
                            // shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: testResultController
                                .categoryWithTestResultDataList.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: examWidget(
                                      testResultController
                                          .testResultDataList[index],
                                      index),
                                ),
                              );
                            },
                          ),
                      ),
                    ),
              ],
            ),
      ),
    );
  }

  Widget examWidget(
    TestResult data,
    int index,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Text(
              data.languages.toString(),
              style: TextStyle(
                color: Color(0xff1CBBA3),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Container(
              child: Text(
                data.packageNameLang1.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          FontAwesomeIcons.idBadge,
                          color: secondaryColor,
                          size: 19,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Rank : ${data.userRank.toString()}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff263238),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              "assets/png_file/examtype.png",
                              width: 22,
                              height: 22,
                            )),
                        Container(
                          child: Text(
                            data.examType.toString().toUpperCase(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff263238),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              "assets/png_file/online.png",
                              width: 22,
                              height: 22,
                            )),
                        Container(
                          child: Text(
                            data.packageType.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff263238),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Icon(
                            FontAwesomeIcons.fileLines,
                            color: secondaryColor,
                            size: 19,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Marks : ${data.userTotalMarks.toString()} / ${data.testNoQuestion.toString()} ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff263238),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.asset(
                                "assets/png_file/test.png",
                                width: 22,
                                height: 22,
                              )),
                          Container(
                            child: Text(
                              "${data.noOfTest.toString()} Tests",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff263238),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              "assets/png_file/date_range.png",
                              width: 22,
                              height: 22,
                            )),
                        Container(
                          child: Text(
                            data.testDate.toString(),
                            //"23-Mar-2022",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff263238),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: index == 0
                ? Showcase(
                    key: testResultController.nine,
                    title: 'View Detail Report',
                    overlayOpacity: 0.2,
                    description: 'Click here to see view detail',
                    radius: BorderRadius.circular(10),
                    child: FlatButton(
                      color: Colors.white,
                      height: 50,
                      onPressed: () async {
                        var result = await (Connectivity().checkConnectivity());
                        if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                          Get.toNamed(ROUTE_TEST_REPORT, arguments: [data.id,false]);
                        } else {
                          Get.snackbar('Internet', 'No Internet Connection',
                              backgroundColor: Colors.red, colorText: Colors.white);
                        }


                      },
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "View Detail Report",
                            style: TextStyle(color: primaryColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: primaryColor),
                            ),
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: primaryColor)),
                    ),
                  )
                : FlatButton(
                    color: Colors.white,
                    height: 50,
                    onPressed: () async {
                      var result = await (Connectivity().checkConnectivity());
                      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                        Get.toNamed(ROUTE_TEST_REPORT, arguments: [data.id,false]);
                      } else {
                        Get.snackbar('Internet', 'No Internet Connection',
                            backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    },
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          "View Detail Report",
                          style: TextStyle(color: primaryColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: primaryColor),
                          ),
                          child: Icon(
                            Icons.arrow_forward_sharp,
                            size: 16,
                            color: primaryColor,
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: primaryColor)),
                  ),
          )
        ],
      ),
    );
  }
}
