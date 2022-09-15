// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/mark_analysis_controller.dart';
import 'package:green_pen/model/mark_analysis_model.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MarkAnalysis extends StatelessWidget {
  MarkAnalysis({Key? key}) : super(key: key);

  var markAnalysisController = Get.put(MarkAnalysisController());

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    markAnalysisController.apiCallingMethod(markAnalysisController.id);
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
        title: Text("Mark Analysis"),
        backgroundColor: primaryColor,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: Obx(
          () => markAnalysisController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  strokeWidth: 1.5,
                ))
              : markAnalysisController.questionDataList.isEmpty
                  ? Container(
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
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                "Total Questions :  ${markAnalysisController.testResultData!.testNoQuestion.toString()}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 150,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      resultWidget(Color(0xff60B687), "Correct :",
                                          "${markAnalysisController.testResultData!.userRightansMarks.toString()}"),
                                      resultWidget(Color(0xffE30211), "Wrong :",
                                          "${markAnalysisController.testResultData!.userWrongansMarks.toString()}"),
                                      resultWidget(
                                          Color(0xffEB996E),
                                          "Negative :",
                                          "${markAnalysisController.testResultData!.userNegativeMarks.toString()}"),
                                      resultWidget(
                                          Color(0xffC7C7C7),
                                          "Unanswered :",
                                          "${markAnalysisController.testResultData!.userSkippedMarks.toString()}"),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                        child: Center(
                                            child: Image.asset(
                                                "assets/png_file/profileIcon.png",
                                                height: 120))),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              width: 170,
                              child: FlatButton(
                                color: secondaryColor,
                                height: 40,
                                minWidth: 170,
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      "Download",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.file_download,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    Spacer()
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                                child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: ansWidget(
                                      markAnalysisController
                                          .questionDataList[index],
                                      index),
                                );
                              },
                              itemCount:
                                  markAnalysisController.questionDataList.length,
                            )),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget ansWidget(
    QuestionData data,
    int index,
  ) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0.8, color: Color(0xffD9D9D9))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Container(
                                child: Text(
                                  "Status :",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "⚈",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: data.status==1 ? Colors.green : data.status==2 ? Colors.red : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Container(
                                child: Text("Mark :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text("${data.mark.toString()}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Container(
                                child: Text(
                                  "Time :",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            WidgetSpan(
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text("${data.timetaken.toString()}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: Container(
                            child: Text(
                              "Topic :",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff263238)),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(data.topicName.toString(),
                                //"General Science",
                                style: TextStyle(
                                    fontSize: 15, color: secondaryColor)),
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
                  padding: const EdgeInsets.all(5.0),
                  child: Text(data.question1.toString(),
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(data.question2.toString(),
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                  color: Color(0xffE3E3E3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Right Answer : ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "${data.correctAnswer.toString()}",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.only(left: 40),
                            child: Text(
                              "Your Answer : ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "${data.userAnswer.toString()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Difficulty Level :',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "${data.difficultyLevel.toString()}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 40,
              width: 40,
              color: primaryColor,
              child: Center(
                child: Text(
                  "${data.queId.toString()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
        ],
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
