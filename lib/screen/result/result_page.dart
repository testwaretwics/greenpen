// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/dashboard_controller.dart';
import 'package:green_pen/controller/home_controller.dart';
import 'package:green_pen/controller/test_report_controller.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TestReportPage extends StatelessWidget {
  TestReportPage({
    Key? key,
    required this.complete,
  }) : super(key: key);
  final complete;

  var testReportController = Get.put(TestReportController());

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    testReportController.apiCallingMethod(testReportController.id);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Report"),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: testReportController.backButton ? false : true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                if(testReportController.backButton){
                  Get.back();
                  Get.back();
                  Get.put(DashboardController()).selectedIndex = 0;
                  Get.put(DashboardController()).update();
                  Get.put(HomeController()).getApiData();
                }else{
                  Get.back();
                }
                //Get.back();
                // WidgetsBinding.instance!.addPostFrameCallback((_){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                // });
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: WillPopScope(
        onWillPop: (){
          return Future.value(testReportController.backButton ? false : true);
        },
        child: SmartRefresher(
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child: Obx(
            () => testReportController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                    strokeWidth: 1.5,
                  ))
                : Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            testReportController.testResultDataList!.category
                                        .toString() !=
                                    ""
                                ? testReportController.testResultDataList!.category
                                    .toString()
                                : "",
                            style:
                                TextStyle(color: primaryLightColor, fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                              testReportController
                                  .testResultDataList!.packageNameLang1
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                testReportController.testResultDataList!.testTime
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(
                                  Icons.menu_book,
                                  size: 24,
                                ),
                              ),
                              Text(
                                  "${testReportController.testResultDataList!.userTotalMarks.toString()} / ${testReportController.testResultDataList!.totalMark.toString()} Marks")
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                Icons.bookmark,
                                size: 24,
                              ),
                            ),
                            Text(
                                "Rank : ${testReportController.testResultDataList!.userRank.toString()}")
                          ],
                        ),
                        complete
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  height: 40,
                                  child: Text(
                                    testReportController
                                        .testResultDataList!.testTitle
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xffD1BD50), fontSize: 14),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 20,
                              ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "Total Questions :  ${testReportController.testResultDataList!.testNoQuestion.toString()}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          height: 180,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  resultWidget(Color(0xff60B687), "Correct :",
                                      "${testReportController.testResultDataList!.userRightansMarks.toString()}"),
                                  resultWidget(Color(0xffE30211), "Wrong :",
                                      "${testReportController.testResultDataList!.userWrongansMarks.toString()}"),
                                  resultWidget(Color(0xffEB996E), "Negative :",
                                      "${testReportController.testResultDataList!.userNegativeMarks.toString()}"),
                                  resultWidget(Color(0xffC7C7C7), "Unanswered :",
                                      "${testReportController.testResultDataList!.userSkippedMarks.toString()}"),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                    child: Center(
                                        child: Image.asset(
                                            "assets/png_file/profileIcon.png",
                                            height: 150))),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(ROUTE_MARK_ANALYSIS,
                                      arguments: testReportController
                                          .testResultDataList!.id);
                                },
                                child: Container(
                                  width: 160,
                                  height: 120,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.grey.shade100,
                                        spreadRadius: 1,
                                        blurRadius: 2)
                                  ]),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 10,
                                        color: Color(0xff9E1081),
                                      ),
                                      Spacer(),
                                      Container(
                                          child: Image.asset(
                                        "assets/png_file/mark_analysis.png",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Mark Analysis",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(ROUTE_DATA_REPORT,
                                      arguments: testReportController
                                          .testResultDataList!.id);
                                },
                                child: Container(
                                  width: 160,
                                  height: 120,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.grey.shade100,
                                        spreadRadius: 1,
                                        blurRadius: 2)
                                  ]),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 10,
                                        color: Color(0xff200038),
                                      ),
                                      Spacer(),
                                      Container(
                                          child: Image.asset(
                                        "assets/png_file/data_reports.png",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                      )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Data Reports",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Text resultWidget(Color color, String title, String mark) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          WidgetSpan(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  '⚈',
                  style: TextStyle(color: color, fontSize: 16),
                ),
              ),
            ),
          ),
          WidgetSpan(
            child: Container(
              width: 110,
              padding: EdgeInsets.only(left: 10),
              child: Text(title),
            ),
          ),
          WidgetSpan(
            child: Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(mark),
            ),
          ),
        ],
      ),
    );
  }
}
