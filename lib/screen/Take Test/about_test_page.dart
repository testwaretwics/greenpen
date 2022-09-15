// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/take_test_detail_controller.dart';
import 'package:green_pen/model/take_test_detail_model.dart';
import 'package:green_pen/screen/cart/test_syllabus.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AboutTestStatus extends StatelessWidget {
  AboutTestStatus({Key? key}) : super(key: key);
  final takeTestDetailController = Get.put(TakeTestDetailController());

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
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
        title: Text("About Test"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: Obx(
          () => takeTestDetailController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : takeTestDetailController.mcqTestDataList.isEmpty &&
                      takeTestDetailController.packageData == null
                  ? Center(
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
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 5),
                              child: Text(
                                "Test Features",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                height: 40,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      takeTestDetailController
                                          .packageData!.packageNameLang1
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color(0xff296ACC),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Image.asset(
                                        "assets/png_file/examtype.png",
                                        width: 22,
                                        height: 22,
                                      )),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      takeTestDetailController
                                          .packageData!.examType
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff263238),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Image.asset(
                                        "assets/png_file/test.png",
                                        width: 22,
                                        height: 22,
                                      )),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "${takeTestDetailController.packageData!.noOfTest.toString()} Tests",
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
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Image.asset(
                                        "assets/png_file/online.png",
                                        width: 22,
                                        height: 22,
                                      )),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      takeTestDetailController
                                          .packageData!.packageType
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff263238),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Image.asset(
                                        "assets/png_file/date_range.png",
                                        width: 22,
                                        height: 22,
                                      )),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "23-Mar-2022",
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
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      "\u{20B9} ",
                                      style: TextStyle(fontSize: 23),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "${takeTestDetailController.packageData!.feesForNew.toString()} /-",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff263238),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Icon(
                                      FontAwesomeIcons.globe,
                                      color: Color(0xff263238),
                                      size: 19,
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      takeTestDetailController
                                          .packageData!.languages
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff263238),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(ROUTE_TEST_SYLLABUS);
                              },
                              child: Text(
                                "View Syllabus Here",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff296ACC),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10),
                              child: Text(
                                "Test Details",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: takeTestDetailController
                                    .mcqTestDataList.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: testDetailWidget(
                                        takeTestDetailController
                                            .mcqTestDataList[index],
                                        index),
                                  );
                                },
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

  Container testDetailWidget(
    McqTest data,
    int index,
  ) {
    return Container(
      height: 120,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Container(
            width: 60,
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${index + 1}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 5),
                          child: Text(
                            data.testTitle.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: primaryColor, fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.lock_open),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: Image.asset(
                            "assets/png_file/times.png",
                            width: 20,
                            height: 20,
                          )),
                      Container(
                        width: 100,
                        child: Text(
                          data.testTime.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff263238),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.asset(
                            "assets/png_file/list_fill.png",
                            width: 22,
                            height: 22,
                          )),
                      Container(
                        width: 93,
                        child: Text(
                          "${data.testNoQuestion.toString()} Questions",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff263238),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: Image.asset(
                            "assets/png_file/date_range.png",
                            width: 22,
                            height: 22,
                          )),
                      Container(
                        width: 100,
                        child: Text(
                          data.date.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff263238),
                          ),
                        ),
                      ),
                      Spacer(),
                      data.testStatus == 1
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: FlatButton(
                                color: secondaryColor,
                                height: 35,
                                minWidth: 105,
                                onPressed: () {
                                  Get.toNamed(ROUTE_TEST_INSTRUCTIONS,
                                      arguments: [
                                        int.parse(data.packageId!),
                                        data.testId
                                      ]);
                                },
                                child: Text(
                                  "Take Test",
                                  style: TextStyle(color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: secondaryColor),
                                ),
                              ),
                            )
                          : data.testStatus == 2
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: FlatButton(
                                    color: Colors.white,
                                    height: 35,
                                    onPressed: () {
                                      Get.toNamed(ROUTE_TEST_INSTRUCTIONS,
                                          arguments: [
                                            int.parse(data.packageId!),
                                            data.testId
                                          ]);
                                    },
                                    child: Text(
                                      "Resume Test",
                                      style: TextStyle(color: secondaryColor),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: secondaryColor),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: FlatButton(
                                    color: Colors.orangeAccent.withOpacity(0.9),
                                    height: 35,
                                    minWidth: 105,
                                    onPressed: () {
                                      Get.toNamed(ROUTE_TEST_REPORT, arguments: [data.resultId,false]);
                                    },
                                    child: Text(
                                      "View Result",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.orangeAccent
                                              .withOpacity(0.9)),
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
