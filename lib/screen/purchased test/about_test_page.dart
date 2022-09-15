// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/about_purchased_tests_controller.dart';
import 'package:green_pen/model/purchased_test_details_model.dart';
import 'package:green_pen/screen/cart/test_syllabus.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';

class AboutPurchasedTest extends StatelessWidget {
  AboutPurchasedTest({Key? key}) : super(key: key);
  var aboutPurchasedTestController = Get.put(AboutPurchasedTestController());
  final String amount = "3000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Test"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Obx(
        () => aboutPurchasedTestController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 40,
                          width: 270,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                aboutPurchasedTestController
                                    .buyTestDetailPackageDetailDataList!
                                    .packageNameLang1
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
                        height: 20,
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
                                aboutPurchasedTestController
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
                                "${aboutPurchasedTestController.buyTestDetailPackageDetailDataList!.noOfTest.toString()} Tests",
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
                                aboutPurchasedTestController
                                    .buyTestDetailPackageDetailDataList!
                                    .packageType
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
                                aboutPurchasedTestController
                                    .buyTestDetailPackageDetailDataList!
                                    .startDate
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "\u{20B9} ",
                                style: TextStyle(fontSize: 23),
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Text(
                                "${aboutPurchasedTestController.buyTestDetailPackageDetailDataList!.feesForNew.toString()} /-",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff263238),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                FontAwesomeIcons.globe,
                                color: Color(0xff263238),
                                size: 19,
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Text(
                                aboutPurchasedTestController
                                    .buyTestDetailPackageDetailDataList!
                                    .languages
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
                                  aboutPurchasedTestController
                                      .mcqTestDataList[index],
                                  index),
                            );
                          },
                          itemCount: aboutPurchasedTestController
                              .mcqTestDataList.length,
                        ),
                      )
                    ],
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
      //width: 372,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60,
            color: Color(0xff1CBBA3),
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
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 5),
                          child: Text(
                            data.testTitle.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xff1CBBA3), fontSize: 18),
                          ),
                        ),
                      ),
                      //Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.lock_open),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            "assets/png_file/times.png",
                            width: 20,
                            height: 20,
                          )),
                      Container(
                        width: 100,
                        child: Text(
                          data.testTime.toString(),
                          //"90 mins",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff263238),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            "assets/png_file/list_fill.png",
                            width: 22,
                            height: 22,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            "assets/png_file/date_range.png",
                            width: 22,
                            height: 22,
                          )),
                      Container(
                        width: 100,
                        child: Text(
                          data.date.toString(),
                          //"23-Mar-2022",
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
          ),
        ],
      ),
    );
  }
}
