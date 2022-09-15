// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/about_test_controller.dart';
import 'package:green_pen/model/buy_test_details_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AboutTest extends StatelessWidget {
  final aboutTestController = Get.put(AboutTestController());
  AboutTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    RefreshController _refreshController = RefreshController(initialRefresh: false);

    void _onRefresh() async{
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      aboutTestController.apiCallingMethod(aboutTestController.packageId);
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    void _onLoading() async{
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      _refreshController.loadComplete();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("About Test"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => aboutTestController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : SmartRefresher(
            controller: _refreshController,
            onLoading: _onLoading,
            onRefresh: _onRefresh,
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 5),
                          child: Row(
                            children: [
                              Text(
                                "Test Features",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 16),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FlatButton(
                                  color: Color(0xff296ACC),
                                  height: 40,
                                  minWidth: 70,
                                  onPressed: () {
                                    if (aboutTestController
                                            .buyTestDetailPackageDetailDataList!
                                            .cartStatus ==
                                        "1") {
                                      Get.snackbar("", "",
                                          messageText: Center(
                                              child: Text(
                                            "This Package is already in cart",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                          colorText: Colors.white,
                                          backgroundColor: Colors.blue,
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else if (aboutTestController
                                            .buyTestDetailPackageDetailDataList!
                                            .orderStatus ==
                                        1) {
                                      Get.snackbar("", "",
                                          messageText: Center(
                                              child: Text(
                                            "This Package is already purchased",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                          colorText: Colors.white,
                                          backgroundColor: Colors.blue,
                                          snackPosition: SnackPosition.BOTTOM);
                                    } else
                                      Get.toNamed(ROUTE_BOOK_FORM, arguments: [
                                        aboutTestController
                                            .buyTestDetailPackageDetailDataList!
                                            .packageId,
                                        aboutTestController
                                            .buyTestDetailPackageDetailDataList!
                                            .feesForNew
                                      ]);
                                  },
                                  child: Text("Book Now"),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            child: Text(
                              aboutTestController
                                  .buyTestDetailPackageDetailDataList!
                                  .packageNameLang1
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff296ACC),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: Image.asset(
                                                "assets/png_file/examtype.png",
                                                height: 22,
                                                width: 22,
                                              )),
                                          Container(
                                            child: Text(
                                              aboutTestController
                                                  .buyTestDetailPackageDetailDataList!
                                                  .examType
                                                  .toString()
                                                  .toUpperCase(),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              child: Image.asset(
                                                "assets/png_file/online.png",
                                                height: 22,
                                                width: 22,
                                              )),
                                          Container(
                                            child: Text(
                                              aboutTestController
                                                  .buyTestDetailPackageDetailDataList!
                                                  .packageType
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Icon(
                                              FontAwesomeIcons.indianRupeeSign,
                                              color: Color(0xff263238),
                                              size: 20),
                                        ),
                                        Container(
                                          child: Text(
                                            "${aboutTestController.buyTestDetailPackageDetailDataList!.feesForNew.toString()}/-",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff263238),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    )
                                  ]),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Image.asset(
                                              "assets/png_file/test.png",
                                              height: 22,
                                              width: 22,
                                            )),
                                        Container(
                                          child: Text(
                                            "${aboutTestController.buyTestDetailPackageDetailDataList!.noOfTest.toString()} Tests",
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Row(children: [
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Image.asset(
                                            "assets/png_file/date_range.png",
                                            height: 22,
                                            width: 22,
                                          )),
                                      Container(
                                        child: Text(
                                          aboutTestController
                                              .buyTestDetailPackageDetailDataList!
                                              .startDate
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff263238),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Icon(
                                          FontAwesomeIcons.globe,
                                          color: Color(0xff263238),
                                          size: 19,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          aboutTestController
                                              .buyTestDetailPackageDetailDataList!
                                              .languages
                                              .toString(),
                                          //"Tamil",
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
                              vertical: 10.0, horizontal: 5),
                          child: Text(
                            "Test Details",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: testDetailWidget(
                                    aboutTestController.mcqTestDataList[index],
                                    index),
                              );
                            },
                            itemCount: aboutTestController.mcqTestDataList.length,
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

  Stack testDetailWidget(
    McqTest data,
    int index,
  ) {
    return Stack(
      children: [
        Container(
          height: 110,
          width: 372,
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
              Container(
                width: 290,
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 10),
                      child: Text(
                        data.testTitle.toString(),
                        maxLines: 1,
                        style:
                            TextStyle(color: Color(0xff1CBBA3), fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              "assets/png_file/times.png",
                              height: 20,
                              width: 20,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              "assets/png_file/list_fill.png",
                              height: 22,
                              width: 22,
                            )),
                        Container(
                          width: 120,
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
                      children: [
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              "assets/png_file/date_range.png",
                              height: 22,
                              width: 22,
                            )),
                        Container(
                          width: 120,
                          child: Text(
                            data.date.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff263238),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 20,
          child: data.testStatus == 1
              ? Image.asset(
                  "assets/png_file/lock.png",
                  height: 22,
                  width: 22,
                )
              : Icon(Icons.lock_open),
        )
      ],
    );
  }
}
