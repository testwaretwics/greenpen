// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/question_controller.dart';
import 'package:green_pen/controller/take_test_detail_controller.dart';
import 'package:green_pen/controller/test_result_controller.dart';
import 'package:green_pen/model/test_panel_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/preferences.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final questionController = Get.put(QuestionController());

  Duration duration = const Duration();
  Duration duration1 = const Duration();
  Timer? timer;
  bool isCountDown = true;
  var countDownDuration;
  var countDownDuration1;
  var hours;
  var minutes;
  var seconds;

  var hours1;
  var minutes1;
  var seconds1;

  void initState() {
    super.initState();
    if(questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == null || questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == "" ) questionController.choiceLanguage = "English" ;

    if(questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == null || questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == "") questionController.choiceLanguage = "Tamil";

    countDownDuration = Duration(
        hours: int.parse(
            questionController.total_time.toString().split(":")[0].toString()),
        minutes: int.parse(
            questionController.total_time.toString().split(":")[1].toString()),
        seconds: int.parse(
            questionController.total_time.toString().split(":")[2].toString()));
    //countDownDuration = Duration(hours: 00,minutes: 00,seconds: 10);

    countDownDuration1 = Duration();
    startTimer();
    reset();
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void reset() {
    if (isCountDown) {
      setState(() {
        duration = countDownDuration;
        duration1 = countDownDuration1;
      });
    } else {
      setState(() {
        duration = const Duration();
        duration1 = const Duration();
      });
    }
  }

  void addTime() {
    final addSeconds = isCountDown ? -1 : 1;
    final addSeconds1 = isCountDown ? 1 : -1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      final seconds1 = duration1.inSeconds + addSeconds1;
      if (seconds < 0 || seconds1 < 0) {
        timer?.cancel();
        timeOverSubmitTestDialog();
      } else {
        duration = Duration(seconds: seconds);
        duration1 = Duration(seconds: seconds1);
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  timeOverSubmitTestDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      title: "Time Over",
      content: Text("Time over on your test so please click the submit button"),
      actions: [
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xff296ACC),
            ),
          ),
          child: FlatButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: secondaryColor),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xff296ACC),
            ),
          ),
          child: FlatButton(
            color: secondaryColor,
            onPressed: () {
              Get.back();
              questionController.apiCallingMethod(
                  questionController
                      .questionCollectionDataList[
                          questionController.selectedIndex]
                      .testId,
                  questionController
                      .questionCollectionDataList[
                          questionController.selectedIndex]
                      .packageId);
            },
            child: Text(
              "Submit Test",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    hours = twoDigits(duration.inHours);
    minutes = twoDigits(duration.inMinutes.remainder(60));
    seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$hours:$minutes:$seconds",
          style: TextStyle(
              color: Color(0xffF97171),
              fontSize: 18,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    hours1 = twoDigits(duration1.inHours);
    minutes1 = twoDigits(duration1.inMinutes.remainder(60));
    seconds1 = twoDigits(duration1.inSeconds.remainder(60));
    return Visibility(
      visible: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$hours1:$minutes1:$seconds1",
            style: TextStyle(
                color: Color(0xffF97171),
                fontSize: 18,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  next() {
    if (mounted)
      setState(() {
        questionController.selectedIndex++;
      });
  }

  @override
  Widget build(BuildContext context) {
    submitTestDialog() {
      Get.defaultDialog(
        radius: 12,
        title: "",
        titleStyle: TextStyle(fontSize: 1),
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Do you want to end the test ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            Text(
                "Check the answers before click the End button Check the answers before click the End button Check the answers before click the End button Check the answers before click the End button"),
          ],
        ),
        actions: [
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xff296ACC),
              ),
            ),
            child: FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xff296ACC),
              ),
            ),
            child: FlatButton(
              color: buttonColor,
              onPressed: () async {
                Get.back();
                //Get.offAndToNamed(ROUTE_TEST_REPORT,arguments: [2,true]);
             await  questionController.apiCallingMethod(
                    questionController
                        .questionCollectionDataList[
                            questionController.selectedIndex]
                        .testId,
                    questionController
                        .questionCollectionDataList[
                            questionController.selectedIndex]
                        .packageId);

              await  Get.put(TestResultController()).apiCallingMethod();
                print("end test");
              },
              child: Text(
                "End Test",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    finalSubmitTestDialog() {
      Get.defaultDialog(
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        title: "Do you want to Submit the test ?",
        content: Text("Check the answers before click the submit button"),
        actions: [
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xff296ACC),
              ),
            ),
            child: FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xff296ACC),
              ),
            ),
            child: FlatButton(
              color: secondaryColor,
              onPressed: () {
                Get.back();
                questionController.apiCallingMethod(
                    questionController
                        .questionCollectionDataList[
                            questionController.selectedIndex]
                        .testId,
                    questionController
                        .questionCollectionDataList[
                            questionController.selectedIndex]
                        .packageId);
              },
              child: Text(
                "Submit Test",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    exitSubmitTestDialog() {
      Get.defaultDialog(
        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        title: "Are you sure ?",
        content: Text("You want to hold the test."),
        actions: [
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xff296ACC),
              ),
            ),
            child: FlatButton(
              onPressed: () {
                // timer?.cancel();
                // Get.back();
                Get.back();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: secondaryColor),
              ),
            ),
          ),
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xff296ACC),
              ),
            ),
            child: FlatButton(
              color: secondaryColor,
              onPressed: () {
                timer?.cancel();
                Get.back();
                Get.back();
                var id = Preferences.getIntValuesSF(Preferences.ORDER_DATA_ID);
                Get.put(TakeTestDetailController()).getApiDataCalling(id);
                // questionController.temporaryStoreApiData(
                //   questionController
                //       .questionCollectionDataList[
                //   questionController.selectedIndex]
                //       .testId,
                //   questionController
                //       .questionCollectionDataList[
                //   questionController.selectedIndex]
                //       .packageId,
                //   questionController
                //       .questionCollectionDataList[
                //   questionController.selectedIndex]
                //       .id,
                //   questionController
                //       .questionCollectionDataList[
                //   questionController.selectedIndex]
                //       .answer,
                //   questionController.selectedAnswer.value,
                //   questionController.total_time.value,
                //   "$hours1:$minutes1:$seconds1",
                //   2,
                // );
                // questionController.questionCollectionDataList[
                // questionController.selectedIndex].userAnswer = questionController.selectedAnswer.value;
                // questionController.questionCollectionDataList[questionController.selectedIndex].answeredType = 2;
                questionController.selectedVal = '';
                questionController.selectedAnswer.value = '';
                next();
              },
              child: Text(
                "Submit Test",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 200),
        child: Container(
          padding: EdgeInsets.all(15),
          color: secondaryColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 300,
                          child: Text(
                            questionController.title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            exitSubmitTestDialog();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.timer, color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "Time Left :",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              buildTime(),
                              buildTime1()
                            ],
                          ),
                        ],
                      ),
                    ]),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: Color(0xff06AEA9),
                        height: 40,
                        minWidth: 140,
                        onPressed: () {
                          submitTestDialog();
                        },
                        child: Text("Submit Test"),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 70,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 3,
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (questionController.selectedIndex <
                        questionController.questionCollectionDataList.length -
                            1) {
                      questionController.temporaryStoreApiData(
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .testId,
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .packageId,
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .id,
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .answer,
                        questionController.selectedAnswer.value,
                        questionController.total_time.value,
                        "$hours1:$minutes1:$seconds1",
                        2,
                      );
                      questionController.questionCollectionDataList[questionController.selectedIndex].userAnswer =
                          questionController.selectedAnswer.value;
                      questionController.questionCollectionDataList[questionController.selectedIndex].answeredType = 2;
                      questionController.selectedVal = '';
                      questionController.selectedAnswer.value = '';
                      next();
                    } else {
                      finalSubmitTestDialog();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color(0xff440078),
                      ),
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Mark for View & Next",
                        style: TextStyle(color: secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (questionController.selectedIndex <
                        questionController.questionCollectionDataList.length -
                            1) {
                      if (questionController.selectedAnswer.value != '') {
                        questionController.temporaryStoreApiData(
                          questionController
                              .questionCollectionDataList[
                                  questionController.selectedIndex]
                              .testId,
                          questionController
                              .questionCollectionDataList[
                                  questionController.selectedIndex]
                              .packageId,
                          questionController
                              .questionCollectionDataList[
                                  questionController.selectedIndex]
                              .id,
                          questionController
                              .questionCollectionDataList[
                                  questionController.selectedIndex]
                              .answer,
                          questionController.selectedAnswer.value,
                          questionController.total_time.value,
                          "$hours1:$minutes1:$seconds1",
                          1,
                        );
                        questionController.questionCollectionDataList[questionController.selectedIndex].userAnswer = questionController.selectedAnswer.value;
                        questionController.questionCollectionDataList[questionController.selectedIndex].answeredType = 1;
                        questionController.selectedVal = '';
                        questionController.selectedAnswer.value = '';
                        print(
                            "USER ANSWER : ${questionController.questionCollectionDataList[questionController.selectedIndex].userAnswer}");
                        next();
                      } else {
                        Get.snackbar("Test Question", "Please select answer..!",
                            colorText: Colors.white,
                            backgroundColor: Colors.redAccent,
                            icon: Icon(Icons.warning));
                      }
                    } else {
                      finalSubmitTestDialog();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff440078),
                      border: Border.all(
                        color: Color(0xff440078),
                      ),
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Save & Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: (){
          exitSubmitTestDialog();
          return Future.value(false);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () =>
            // questionController.isLoading.value
            //     ? const Center(
            //         child: LinearProgressIndicator(
            //           // value: 10.0,//controller!.value.toDouble(),
            //          // semanticsLabel: 'Linear progress indicator',
            //         ),) :
            questionController.questionCollectionDataList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                        backgroundColor: primaryColor,
                        strokeWidth: 1.5,
                      ))
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Answered - ${questionController.answered.toString()}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Unanswered - ${questionController.unanswered.toString()}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Stack(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (mounted)
                                            setState(() {
                                              if (questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == null
                                                  || questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == "") {
                                                Get.snackbar("Language",
                                                    "Don't have to change the language otherwise showing empty question and empty answers",
                                                    colorText: Colors.white,
                                                    backgroundColor: Colors
                                                        .red);
                                              }
                                              // else if (questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == null
                                              //     || questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == ""
                                              //     && questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == null
                                              //     || questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == "") {
                                              //   if(questionController.questionCollectionDataList[questionController.selectedIndex].lang2QuestionImage == null
                                              //       || questionController.questionCollectionDataList[questionController.selectedIndex].lang2QuestionImage == ""){
                                              //     Get.snackbar("Language",
                                              //         "Don't have to change the language otherwise showing empty question and empty answers",
                                              //         colorText: Colors.white,
                                              //         backgroundColor: Colors
                                              //             .red);
                                              //   }
                                              // }
                                              questionController.choiceLanguage = "English";
                                            });
                                        },
                                        icon: Text(
                                          "A",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            questionController.choiceLanguage ==
                                                        '' ||
                                                    questionController
                                                            .choiceLanguage ==
                                                        'English'
                                                ? true
                                                : false,
                                        child: Positioned(
                                          bottom: 8.0,
                                          right: 15,
                                          child: Container(
                                              height: 4,
                                              width: 20,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.compare_arrows_rounded),
                                  Stack(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (mounted)
                                            setState(() {
                                              if(questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == null ||
                                                questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == "" ){
                                                Get.snackbar("Language",
                                                    "Don't have to change the language otherwise showing empty question and empty answers",
                                                    colorText: Colors.white,
                                                    backgroundColor: Colors.red);
                                              }
                                              // else if (questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == null
                                              //     || questionController.questionCollectionDataList[questionController.selectedIndex].lang1Question == ""
                                              //         && questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == null
                                              //     || questionController.questionCollectionDataList[questionController.selectedIndex].lang2Question == "") {
                                              //
                                              //   if(questionController.questionCollectionDataList[questionController.selectedIndex].lang1QuestionImage == null
                                              //       || questionController.questionCollectionDataList[questionController.selectedIndex].lang1QuestionImage == ""){
                                              //     Get.snackbar("Language",
                                              //         "Don't have to change the language otherwise showing empty question and empty answers",
                                              //         colorText: Colors.white,
                                              //         backgroundColor: Colors
                                              //             .red);
                                              //   }
                                              //
                                              // }
                                              questionController.choiceLanguage = "Tamil";
                                            });
                                        },
                                        icon: Text(
                                          "அ",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                            questionController.choiceLanguage ==
                                                        '' ||
                                                    questionController
                                                            .choiceLanguage ==
                                                        'English'
                                                ? false
                                                : true,
                                        child: Positioned(
                                          bottom: 8.0,
                                          right: 15,
                                          child: Container(
                                              height: 4,
                                              width: 20,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            qstnWidget(
                                questionController.questionCollectionDataList[
                                    questionController.selectedIndex]),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  questionWarnDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding:
            EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return Container(
              height: height / 3.5,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Question Answer Pattern",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: Container(
                            child: Text(
                              '⚈   ',
                              style: TextStyle(
                                  color: Color(0xff60B687),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            child: Text("Questions Answered"),
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
                              '⚈   ',
                              style: TextStyle(
                                  color: Color(0xffC4C4C4),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            child: Text("Questions UnAnswered"),
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
                              '⚈   ',
                              style: TextStyle(
                                  color: Color(0xff1E4F66),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            child: Text("Questions marked for review"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Container qstnWidget(QuestionCollections data) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            questionWarnDialog();
                          },
                          child: Icon(
                            Icons.info_rounded,
                            color: Color(0xffF2D925),
                            size: 24,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Question ${questionController.selectedIndex + 1} of ${questionController.questionCollectionDataList.length}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 35),
                      child: Text(
                        "⚈  Mark ${data.mark}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff1CBBA3),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    questionController.selectedVal = '';
                    questionController.selectedAnswer.value = '';
                    if (questionController.selectedIndex < questionController.questionCollectionDataList.length - 1) {
                      questionController.temporaryStoreApiData(
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .testId,
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .packageId,
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .id,
                        questionController
                            .questionCollectionDataList[
                        questionController.selectedIndex]
                            .answer,
                        questionController.selectedAnswer.value,
                        questionController.total_time.value,
                        "$hours1:$minutes1:$seconds1",
                        0,
                      );
                      questionController.questionCollectionDataList[
                      questionController.selectedIndex].userAnswer = questionController.selectedAnswer.value;
                      questionController.questionCollectionDataList[questionController.selectedIndex].answeredType = 0;
                      //next();
                      // if (questionController.selectedAnswer.value != '') {
                      //
                      // } else {
                      //   Get.snackbar("Test Question", "Please select answer..!",
                      //       colorText: Colors.white,
                      //       backgroundColor: Colors.redAccent,
                      //       icon: Icon(Icons.warning));
                      // }
                    }
                  },
                  child: Text(
                    "Clear Response",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xffCC2929),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 70,
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 30,
                    ),
                    onTap: () {
                      setState(() {
                        if (questionController.scrollIndexPosition != 0) {
                          questionController.scrollIndexPosition -= 2;
                          questionController.itemScrollController.scrollTo(
                              index: questionController.scrollIndexPosition,
                              duration: Duration(seconds: 1));
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: ScrollablePositionedList.builder(
                      itemCount:
                          questionController.questionCollectionDataList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              questionController.selectedIndex = index;
                              questionController.selectedVal = '';
                              print(
                                  "Selected Index : ${questionController.selectedIndex}");
                              print(
                                  "Selected Index : ${questionController.itemPositionsListener.itemPositions.value}");
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              color: questionController.selectedIndex == index ? Colors.teal : Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                                "${index+1}",
                                style: TextStyle(
                                    color: questionController.selectedIndex == index
                                      ? Colors.white
                                      : questionController.questionCollectionDataList[index].answeredType=="" ?
                                        (
                                            questionController.questionCollectionDataList[index].status==1 ? Colors.green :
                                            questionController.questionCollectionDataList[index].status==0 ? Colors.black :
                                        questionController.questionCollectionDataList[index].status==2 ? questionController.questionCollectionDataList[index].userAnswer=="" ? Colors.orange :  Colors.purple
                                      : Colors.black)
                                      :  (
                                        questionController.questionCollectionDataList[index].answeredType==1 ? Colors.green :
                                        questionController.questionCollectionDataList[index].answeredType== 0 ? Colors.black :
                                      questionController.questionCollectionDataList[index].answeredType==2 ? questionController.questionCollectionDataList[index].userAnswer=="" ? Colors.orange : Colors.purple
                                      : Colors.black)
                                )
                            )
                          ),
                        ),
                      ),
                      scrollDirection: Axis.horizontal,
                      itemScrollController:
                          questionController.itemScrollController,
                      itemPositionsListener:
                          questionController.itemPositionsListener,
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 30,
                    ),
                    onTap: () {
                      setState(() {
                        questionController.scrollIndexPosition += 2;
                        questionController.itemScrollController.scrollTo(
                            index: questionController.scrollIndexPosition,
                            duration: Duration(seconds: 1));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          if (data.questionType == "Choice")
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: questionController.choiceLanguage == "" ||
                            questionController.choiceLanguage == "English"
                        ? HtmlWidget(
                            data.lang2Question.toString(),
                            textStyle: TextStyle(color: Colors.black),
                          )
                        : HtmlWidget(
                            data.lang1Question.toString(),
                            textStyle: TextStyle(color: Colors.black),
                          ),
                  ),
                  if (data.userAnswer != "")
                    if (data.answeredType != "")
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: questionController.choiceOptionList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: questionController.selectedVal == index
                                          ? Colors.blue
                                          : questionController.choiceOptionList[index] == data.userAnswer
                                          ? questionController.selectedVal=="" ?
                                      (data.answeredType==1 ? Colors.green :
                                      data.answeredType==2 ? Colors.purple
                                          : Colors.blue)
                                          : Colors.transparent
                                          : Colors.transparent
                                  ),
                                ),
                                child: RadioListTile(
                                  toggleable: true,
                                  activeColor: questionController.selectedVal == index ? Colors.blue :
                                  (data.answeredType==1 ? Colors.green :
                                  data.answeredType==2 ? Colors.purple
                                      : Colors.blue),
                                  value: index,
                                  contentPadding: EdgeInsets.zero,
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (questionController.choiceLanguage ==
                                          "" ||
                                          questionController.choiceLanguage ==
                                              "English")
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            index == 0
                                                ? Text(
                                                data.lang2OptionA.toString())
                                                : index == 1
                                                ? Text(data.lang2OptionB
                                                .toString())
                                                : index == 2
                                                ? Text(data.lang2OptionC
                                                .toString())
                                                : index == 3
                                                ? Text(data
                                                .lang2OptionD
                                                .toString())
                                                : Text(data
                                                .lang2OptionE
                                                .toString()),
                                          ],
                                        )
                                      else
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            index == 0
                                                ? Text(
                                                data.lang1OptionA.toString())
                                                : index == 1
                                                ? Text(data.lang1OptionB
                                                .toString())
                                                : index == 2
                                                ? Text(data.lang1OptionC
                                                .toString())
                                                : index == 3
                                                ? Text(data
                                                .lang1OptionD
                                                .toString())
                                                : Text(data
                                                .lang1OptionE
                                                .toString()),
                                          ],
                                        )
                                    ],
                                  ),
                                  groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                      ? questionController.selectedVal=="" ? index
                                      : questionController.selectedVal : questionController.selectedVal,
                                  onChanged: (value) {
                                    // if (mounted)
                                    setState(
                                          () {
                                        questionController.selectedVal = value;
                                        if (value == 0) {
                                          questionController
                                              .selectedAnswer.value = "A";
                                        } else if (value == 1) {
                                          questionController
                                              .selectedAnswer.value = "B";
                                        } else if (value == 2) {
                                          questionController
                                              .selectedAnswer.value = "C";
                                        } else if (value == 3) {
                                          questionController
                                              .selectedAnswer.value = "D";
                                        } else if (value == 4) {
                                          questionController
                                              .selectedAnswer.value = "E";
                                        }
                                        print(
                                            "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    else
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionController.choiceOptionList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: questionController.selectedVal == index
                                        ? Colors.blue
                                        : questionController.choiceOptionList[index] == data.userAnswer
                                        ? questionController.selectedVal=="" ?
                                        (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                                        questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                        : Colors.blue)
                                        : Colors.transparent
                                        : Colors.transparent
                                ),
                              ),
                              child: RadioListTile(
                                toggleable: true,
                                activeColor: questionController.selectedVal == index ? Colors.blue :
                                (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                                questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                    : Colors.blue),
                                value: index,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (questionController.choiceLanguage ==
                                            "" ||
                                        questionController.choiceLanguage ==
                                            "English")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang2OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang2OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang2OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang2OptionD
                                                              .toString())
                                                          : data.lang2OptionE!.isEmpty || data.lang2OptionE == "" || data.lang2OptionE == null ? Text("") : Text(data.lang2OptionE.toString()),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang1OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang1OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang1OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang1OptionD
                                                              .toString())
                                                          : Text(data
                                                              .lang1OptionE
                                                              .toString()),
                                        ],
                                      )
                                  ],
                                ),
                                groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                    ? questionController.selectedVal=="" ? index
                                    : questionController.selectedVal : questionController.selectedVal,
                                onChanged: (value) {
                                  // if (mounted)
                                  setState(
                                    () {
                                      questionController.selectedVal = value;
                                      if (value == 0) {
                                        questionController
                                            .selectedAnswer.value = "A";
                                      } else if (value == 1) {
                                        questionController
                                            .selectedAnswer.value = "B";
                                      } else if (value == 2) {
                                        questionController
                                            .selectedAnswer.value = "C";
                                      } else if (value == 3) {
                                        questionController
                                            .selectedAnswer.value = "D";
                                      } else if (value == 4) {
                                        questionController
                                            .selectedAnswer.value = "E";
                                      }
                                      print(
                                          "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionController.choiceOptionList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color:
                                        questionController.selectedVal == index
                                            ? Colors.blue
                                            : Colors.transparent),
                              ),
                              child: RadioListTile(
                                toggleable: true,
                                activeColor: Colors.blue,
                                value: index,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (questionController.choiceLanguage ==
                                            "" ||
                                        questionController.choiceLanguage ==
                                            "English")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang2OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang2OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang2OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang2OptionD
                                                              .toString())
                                                          : Text(data
                                                              .lang2OptionE
                                                              .toString()),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang1OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang1OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang1OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang1OptionD
                                                              .toString())
                                                          : Text(data
                                                              .lang1OptionE
                                                              .toString()),
                                        ],
                                      )
                                  ],
                                ),
                                groupValue: questionController.selectedVal,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      questionController.selectedVal = value;
                                      if (value == 0) {
                                        questionController
                                            .selectedAnswer.value = "A";
                                      } else if (value == 1) {
                                        questionController
                                            .selectedAnswer.value = "B";
                                      } else if (value == 2) {
                                        questionController
                                            .selectedAnswer.value = "C";
                                      } else if (value == 3) {
                                        questionController
                                            .selectedAnswer.value = "D";
                                      } else if (value == 4) {
                                        questionController
                                            .selectedAnswer.value = "E";
                                      }
                                      print(
                                          "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            )
          else if (data.questionType == "Grammar")
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: questionController.choiceLanguage == "" ||
                            questionController.choiceLanguage == "English"
                        ? HtmlWidget(
                            data.lang2Question.toString(),
                            textStyle: TextStyle(color: Colors.black),
                          )
                        : HtmlWidget(
                            data.lang1Question.toString(),
                            textStyle: TextStyle(color: Colors.black),
                          ),
                  ),
                  if (data.userAnswer != "")
                    if (data.answeredType != "")
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: questionController.choiceOptionList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: questionController.selectedVal == index
                                          ? Colors.blue
                                          : questionController.choiceOptionList[index] == data.userAnswer
                                          ? questionController.selectedVal=="" ?
                                      (data.answeredType==1 ? Colors.green :
                                      data.answeredType==2 ? Colors.purple
                                          : Colors.blue)
                                          : Colors.transparent
                                          : Colors.transparent
                                  ),
                                ),
                                child: RadioListTile(
                                  toggleable: true,
                                  activeColor: questionController.selectedVal == index ? Colors.blue :
                                  (data.answeredType==1 ? Colors.green :
                                  data.answeredType==2 ? Colors.purple
                                      : Colors.blue),
                                  value: index,
                                  contentPadding: EdgeInsets.zero,
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (questionController.choiceLanguage ==
                                          "" ||
                                          questionController.choiceLanguage ==
                                              "English")
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            index == 0
                                                ? Text(
                                                data.lang2OptionA.toString())
                                                : index == 1
                                                ? Text(data.lang2OptionB
                                                .toString())
                                                : index == 2
                                                ? Text(data.lang2OptionC
                                                .toString())
                                                : index == 3
                                                ? Text(data
                                                .lang2OptionD
                                                .toString())
                                                : Text(data
                                                .lang2OptionE
                                                .toString()),
                                          ],
                                        )
                                      else
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            index == 0
                                                ? Text(
                                                data.lang1OptionA.toString())
                                                : index == 1
                                                ? Text(data.lang1OptionB
                                                .toString())
                                                : index == 2
                                                ? Text(data.lang1OptionC
                                                .toString())
                                                : index == 3
                                                ? Text(data
                                                .lang1OptionD
                                                .toString())
                                                : Text(data
                                                .lang1OptionE
                                                .toString()),
                                          ],
                                        )
                                    ],
                                  ),
                                  groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                      ? questionController.selectedVal=="" ? index
                                      : questionController.selectedVal : questionController.selectedVal,
                                  onChanged: (value) {
                                    setState(
                                          () {
                                        questionController.selectedVal = value;
                                        if (value == 0) {
                                          questionController
                                              .selectedAnswer.value = "A";
                                        } else if (value == 1) {
                                          questionController
                                              .selectedAnswer.value = "B";
                                        } else if (value == 2) {
                                          questionController
                                              .selectedAnswer.value = "C";
                                        } else if (value == 3) {
                                          questionController
                                              .selectedAnswer.value = "D";
                                        } else if (value == 4) {
                                          questionController
                                              .selectedAnswer.value = "E";
                                        }
                                        print(
                                            "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    else
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionController.choiceOptionList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: questionController.selectedVal == index
                                        ? Colors.blue
                                        : questionController.choiceOptionList[index] == data.userAnswer
                                        ? questionController.selectedVal=="" ?
                                        (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                                        questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                            : Colors.blue)
                                        : Colors.transparent
                                        : Colors.transparent
                                ),
                              ),
                              child: RadioListTile(
                                toggleable: true,
                                activeColor: questionController.selectedVal == index ? Colors.blue :
                                (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                                questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                    : Colors.blue),
                                value: index,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (questionController.choiceLanguage ==
                                            "" ||
                                        questionController.choiceLanguage ==
                                            "English")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang2OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang2OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang2OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang2OptionD
                                                              .toString())
                                                          : Text(data
                                                              .lang2OptionE
                                                              .toString()),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang1OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang1OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang1OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang1OptionD
                                                              .toString())
                                                          : Text(data
                                                              .lang1OptionE
                                                              .toString()),
                                        ],
                                      )
                                  ],
                                ),
                                groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                    ? questionController.selectedVal=="" ? index
                                    : questionController.selectedVal : questionController.selectedVal,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      questionController.selectedVal = value;
                                      if (value == 0) {
                                        questionController
                                            .selectedAnswer.value = "A";
                                      } else if (value == 1) {
                                        questionController
                                            .selectedAnswer.value = "B";
                                      } else if (value == 2) {
                                        questionController
                                            .selectedAnswer.value = "C";
                                      } else if (value == 3) {
                                        questionController
                                            .selectedAnswer.value = "D";
                                      } else if (value == 4) {
                                        questionController
                                            .selectedAnswer.value = "E";
                                      }
                                      print(
                                          "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionController.choiceOptionList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color:
                                        questionController.selectedVal == index
                                            ? Colors.blue
                                            : Colors.transparent),
                              ),
                              child: RadioListTile(
                                toggleable: true,
                                activeColor: Colors.blue,
                                value: index,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (questionController.choiceLanguage ==
                                            "" ||
                                        questionController.choiceLanguage ==
                                            "English")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang2OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang2OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang2OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang2OptionD
                                                              .toString())
                                                          : Text(data
                                                              .lang2OptionE
                                                              .toString()),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(
                                                  data.lang1OptionA.toString())
                                              : index == 1
                                                  ? Text(data.lang1OptionB
                                                      .toString())
                                                  : index == 2
                                                      ? Text(data.lang1OptionC
                                                          .toString())
                                                      : index == 3
                                                          ? Text(data
                                                              .lang1OptionD
                                                              .toString())
                                                          : Text(data
                                                              .lang1OptionE
                                                              .toString()),
                                        ],
                                      )
                                  ],
                                ),
                                groupValue: questionController.selectedVal,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      questionController.selectedVal = value;
                                      if (value == 0) {
                                        questionController
                                            .selectedAnswer.value = "A";
                                      } else if (value == 1) {
                                        questionController
                                            .selectedAnswer.value = "B";
                                      } else if (value == 2) {
                                        questionController
                                            .selectedAnswer.value = "C";
                                      } else if (value == 3) {
                                        questionController
                                            .selectedAnswer.value = "D";
                                      } else if (value == 4) {
                                        questionController
                                            .selectedAnswer.value = "E";
                                      }
                                      print(
                                          "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            )
          else if (data.questionType == "Imagetype")
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: questionController.choiceLanguage == "" ||
                            questionController.choiceLanguage == "English"
                        ? HtmlWidget(
                            data.lang2QuestionImage.toString(),
                            textStyle: TextStyle(color: Colors.black),
                          )
                        : HtmlWidget(
                            data.lang1QuestionImage.toString(),
                            textStyle: TextStyle(color: Colors.black),
                          ),
                  ),
                  if (data.userAnswer != "")
                    if (data.answeredType != "")
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: questionController.choiceOptionList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: questionController.selectedVal == index
                                          ? Colors.blue
                                          : questionController.choiceOptionList[index] == data.userAnswer
                                          ? questionController.selectedVal=="" ?
                                      (data.answeredType==1 ? Colors.green :
                                      data.answeredType==2 ? Colors.purple
                                          : Colors.blue)
                                          : Colors.transparent
                                          : Colors.transparent
                                  ),
                                ),
                                child: RadioListTile(
                                  toggleable: true,
                                  activeColor: questionController.selectedVal == index ? Colors.blue :
                                  (data.answeredType==1 ? Colors.green :
                                  data.answeredType==2 ? Colors.purple
                                      : Colors.blue),
                                  value: index,
                                  contentPadding: EdgeInsets.zero,
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (questionController.choiceLanguage ==
                                          "" ||
                                          questionController.choiceLanguage ==
                                              "English")
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            index == 0
                                                ? HtmlWidget(data
                                                .lang2OptionAImage
                                                .toString())
                                                : index == 1
                                                ? HtmlWidget(data
                                                .lang2OptionBImage
                                                .toString())
                                                : index == 2
                                                ? HtmlWidget(data
                                                .lang2OptionCImage
                                                .toString())
                                                : index == 3
                                                ? HtmlWidget(data
                                                .lang2OptionDImage
                                                .toString())
                                                : HtmlWidget(data
                                                .lang2OptionEImage
                                                .toString()),
                                          ],
                                        )
                                      else
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            index == 0
                                                ? HtmlWidget(data
                                                .lang1OptionAImage
                                                .toString())
                                                : index == 1
                                                ? HtmlWidget(data
                                                .lang1OptionBImage
                                                .toString())
                                                : index == 2
                                                ? HtmlWidget(data
                                                .lang1OptionCImage
                                                .toString())
                                                : index == 3
                                                ? HtmlWidget(data
                                                .lang1OptionDImage
                                                .toString())
                                                : HtmlWidget(data
                                                .lang1OptionEImage
                                                .toString()),
                                          ],
                                        )
                                    ],
                                  ),
                                  groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                      ? questionController.selectedVal=="" ? index
                                      : questionController.selectedVal : questionController.selectedVal,
                                  onChanged: (value) {
                                    setState(
                                          () {
                                        questionController.selectedVal = value;
                                        if (value == 0) {
                                          questionController
                                              .selectedAnswer.value = "A";
                                        } else if (value == 1) {
                                          questionController
                                              .selectedAnswer.value = "B";
                                        } else if (value == 2) {
                                          questionController
                                              .selectedAnswer.value = "C";
                                        } else if (value == 3) {
                                          questionController
                                              .selectedAnswer.value = "D";
                                        } else if (value == 4) {
                                          questionController
                                              .selectedAnswer.value = "E";
                                        }
                                        print(
                                            "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    else
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionController.choiceOptionList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: questionController.selectedVal == index
                                        ? Colors.blue
                                        : questionController.choiceOptionList[index] == data.userAnswer
                                        ? questionController.selectedVal=="" ?
                                          (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                                          questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                        : Colors.blue)
                                        : Colors.transparent
                                        : Colors.transparent
                                ),
                              ),
                              child: RadioListTile(
                                toggleable: true,
                                activeColor: questionController.selectedVal == index ? Colors.blue :
                                (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                                questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                    : Colors.blue),
                                value: index,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (questionController.choiceLanguage ==
                                            "" ||
                                        questionController.choiceLanguage ==
                                            "English")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? HtmlWidget(data
                                                  .lang2OptionAImage
                                                  .toString())
                                              : index == 1
                                                  ? HtmlWidget(data
                                                      .lang2OptionBImage
                                                      .toString())
                                                  : index == 2
                                                      ? HtmlWidget(data
                                                          .lang2OptionCImage
                                                          .toString())
                                                      : index == 3
                                                          ? HtmlWidget(data
                                                              .lang2OptionDImage
                                                              .toString())
                                                          : HtmlWidget(data
                                                              .lang2OptionEImage
                                                              .toString()),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? HtmlWidget(data
                                                  .lang1OptionAImage
                                                  .toString())
                                              : index == 1
                                                  ? HtmlWidget(data
                                                      .lang1OptionBImage
                                                      .toString())
                                                  : index == 2
                                                      ? HtmlWidget(data
                                                          .lang1OptionCImage
                                                          .toString())
                                                      : index == 3
                                                          ? HtmlWidget(data
                                                              .lang1OptionDImage
                                                              .toString())
                                                          : HtmlWidget(data
                                                              .lang1OptionEImage
                                                              .toString()),
                                        ],
                                      )
                                  ],
                                ),
                                groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                    ? questionController.selectedVal=="" ? index
                                    : questionController.selectedVal : questionController.selectedVal,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      questionController.selectedVal = value;
                                      if (value == 0) {
                                        questionController
                                            .selectedAnswer.value = "A";
                                      } else if (value == 1) {
                                        questionController
                                            .selectedAnswer.value = "B";
                                      } else if (value == 2) {
                                        questionController
                                            .selectedAnswer.value = "C";
                                      } else if (value == 3) {
                                        questionController
                                            .selectedAnswer.value = "D";
                                      } else if (value == 4) {
                                        questionController
                                            .selectedAnswer.value = "E";
                                      }
                                      print(
                                          "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionController.choiceOptionList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color:
                                        questionController.selectedVal == index
                                            ? Colors.blue
                                            : Colors.transparent),
                              ),
                              child: RadioListTile(
                                toggleable: true,
                                activeColor: Colors.blue,
                                value: index,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (questionController.choiceLanguage ==
                                            "" ||
                                        questionController.choiceLanguage ==
                                            "English")
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? HtmlWidget(data
                                                  .lang2OptionAImage
                                                  .toString())
                                              : index == 1
                                                  ? HtmlWidget(data
                                                      .lang2OptionBImage
                                                      .toString())
                                                  : index == 2
                                                      ? HtmlWidget(data
                                                          .lang2OptionCImage
                                                          .toString())
                                                      : index == 3
                                                          ? HtmlWidget(data
                                                              .lang2OptionDImage
                                                              .toString())
                                                          : HtmlWidget(data
                                                              .lang2OptionEImage
                                                              .toString()),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? HtmlWidget(data
                                                  .lang1OptionAImage
                                                  .toString())
                                              : index == 1
                                                  ? HtmlWidget(data
                                                      .lang1OptionBImage
                                                      .toString())
                                                  : index == 2
                                                      ? HtmlWidget(data
                                                          .lang1OptionCImage
                                                          .toString())
                                                      : index == 3
                                                          ? HtmlWidget(data
                                                              .lang1OptionDImage
                                                              .toString())
                                                          : HtmlWidget(data
                                                              .lang1OptionEImage
                                                              .toString()),
                                        ],
                                      )
                                  ],
                                ),
                                groupValue: questionController.selectedVal,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      questionController.selectedVal = value;
                                      if (value == 0) {
                                        questionController
                                            .selectedAnswer.value = "A";
                                      } else if (value == 1) {
                                        questionController
                                            .selectedAnswer.value = "B";
                                      } else if (value == 2) {
                                        questionController
                                            .selectedAnswer.value = "C";
                                      } else if (value == 3) {
                                        questionController
                                            .selectedAnswer.value = "D";
                                      } else if (value == 4) {
                                        questionController
                                            .selectedAnswer.value = "E";
                                      }
                                      print(
                                          "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            )
          else if (data.questionType == "Match")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: questionController.choiceLanguage == "" ||
                          questionController.choiceLanguage == "English"
                      ? HtmlWidget(
                          data.lang2Question.toString(),
                          textStyle: TextStyle(color: Colors.black),
                        )
                      : HtmlWidget(
                          data.lang1Question.toString(),
                          textStyle: TextStyle(color: Colors.black),
                        ),
                ),
                if (questionController.choiceLanguage == "" ||
                    questionController.choiceLanguage == "English")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.lang2OptionA.toString()),
                            SizedBox(height: 10),
                            Text(data.lang2OptionB.toString()),
                            SizedBox(height: 10),
                            Text(data.lang2OptionC.toString()),
                            SizedBox(height: 10),
                            Text(data.lang2OptionD.toString()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.lang2OptionP.toString()),
                            SizedBox(height: 10),
                            Text(data.lang2OptionQ.toString()),
                            SizedBox(height: 10),
                            Text(data.lang2OptionR.toString()),
                            SizedBox(height: 10),
                            Text(data.lang2OptionS.toString()),
                          ],
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.lang1OptionA.toString()),
                            SizedBox(height: 10),
                            Text(data.lang1OptionB.toString()),
                            SizedBox(height: 10),
                            Text(data.lang1OptionC.toString()),
                            SizedBox(height: 10),
                            Text(data.lang1OptionD.toString()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.lang1OptionP.toString()),
                            SizedBox(height: 10),
                            Text(data.lang1OptionQ.toString()),
                            SizedBox(height: 10),
                            Text(data.lang1OptionR.toString()),
                            SizedBox(height: 10),
                            Text(data.lang1OptionS.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (data.userAnswer != "")
                  if (data.answeredType != "")
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: questionController.matchOptionList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: questionController.selectedVal == index
                                        ? Colors.blue
                                        : questionController.choiceOptionList[index] == data.userAnswer
                                        ? questionController.selectedVal=="" ?
                                    (data.answeredType==1 ? Colors.green :
                                    data.answeredType==2 ? Colors.purple
                                        : Colors.blue)
                                        : Colors.transparent
                                        : Colors.transparent
                                ),
                              ),
                              child: RadioListTile(
                                toggleable: true,
                                activeColor: questionController.selectedVal == index ? Colors.blue :
                                (data.answeredType==1 ? Colors.green :
                                data.answeredType==2 ? Colors.purple
                                    : Colors.blue),
                                value: index,
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (questionController.choiceLanguage == "" ||
                                        questionController.choiceLanguage ==
                                            "English")
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(data.lang2AnswerA.toString())
                                              : index == 1
                                              ? Text(data.lang2AnswerB
                                              .toString())
                                              : index == 2
                                              ? Text(data.lang2AnswerC
                                              .toString())
                                              : index == 3
                                              ? Text(data.lang2AnswerD
                                              .toString())
                                              : Text(data.lang2AnswerE
                                              .toString()),
                                        ],
                                      )
                                    else
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          index == 0
                                              ? Text(data.lang1AnswerA.toString())
                                              : index == 1
                                              ? Text(data.lang1AnswerB
                                              .toString())
                                              : index == 2
                                              ? Text(data.lang1AnswerC
                                              .toString())
                                              : index == 3
                                              ? Text(data.lang1AnswerD
                                              .toString())
                                              : Text(data.lang1AnswerE
                                              .toString()),
                                        ],
                                      )
                                  ],
                                ),
                                groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                    ? questionController.selectedVal=="" ? index
                                    : questionController.selectedVal : questionController.selectedVal,
                                onChanged: (value) {
                                  setState(
                                        () {
                                      questionController.selectedVal = value;
                                      if (value == 0) {
                                        questionController.selectedAnswer.value =
                                        "A";
                                      } else if (value == 1) {
                                        questionController.selectedAnswer.value =
                                        "B";
                                      } else if (value == 2) {
                                        questionController.selectedAnswer.value =
                                        "C";
                                      } else if (value == 3) {
                                        questionController.selectedAnswer.value =
                                        "D";
                                      } else if (value == 4) {
                                        questionController.selectedAnswer.value =
                                        "E";
                                      }
                                      print(
                                          "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  else
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: questionController.matchOptionList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: questionController.selectedVal == index
                                      ? Colors.blue
                                      : questionController.choiceOptionList[index] == data.userAnswer
                                      ? questionController.selectedVal=="" ?
                                        (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                                        questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                            : Colors.blue)
                                      : Colors.transparent
                                      : Colors.transparent
                              ),
                            ),
                            child: RadioListTile(
                              toggleable: true,
                              activeColor: questionController.selectedVal == index ? Colors.blue :
                              (questionController.questionCollectionDataList[questionController.selectedIndex].status==1 ? Colors.green :
                              questionController.questionCollectionDataList[questionController.selectedIndex].status==2 ? Colors.purple
                                  : Colors.blue),
                              value: index,
                              contentPadding: EdgeInsets.zero,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (questionController.choiceLanguage == "" ||
                                      questionController.choiceLanguage ==
                                          "English")
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        index == 0
                                            ? Text(data.lang2AnswerA.toString())
                                            : index == 1
                                                ? Text(data.lang2AnswerB
                                                    .toString())
                                                : index == 2
                                                    ? Text(data.lang2AnswerC
                                                        .toString())
                                                    : index == 3
                                                        ? Text(data.lang2AnswerD
                                                            .toString())
                                                        : Text(data.lang2AnswerE
                                                            .toString()),
                                      ],
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        index == 0
                                            ? Text(data.lang1AnswerA.toString())
                                            : index == 1
                                                ? Text(data.lang1AnswerB
                                                    .toString())
                                                : index == 2
                                                    ? Text(data.lang1AnswerC
                                                        .toString())
                                                    : index == 3
                                                        ? Text(data.lang1AnswerD
                                                            .toString())
                                                        : Text(data.lang1AnswerE
                                                            .toString()),
                                      ],
                                    )
                                ],
                              ),
                              groupValue: questionController.choiceOptionList[index] == data.userAnswer
                                  ? questionController.selectedVal=="" ? index
                                  : questionController.selectedVal : questionController.selectedVal,
                              onChanged: (value) {
                                setState(
                                  () {
                                    questionController.selectedVal = value;
                                    if (value == 0) {
                                      questionController.selectedAnswer.value =
                                          "A";
                                    } else if (value == 1) {
                                      questionController.selectedAnswer.value =
                                          "B";
                                    } else if (value == 2) {
                                      questionController.selectedAnswer.value =
                                          "C";
                                    } else if (value == 3) {
                                      questionController.selectedAnswer.value =
                                          "D";
                                    } else if (value == 4) {
                                      questionController.selectedAnswer.value =
                                          "E";
                                    }
                                    print(
                                        "SelectedAnswer : ${questionController.selectedAnswer.value}");
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: questionController.matchOptionList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: questionController.selectedVal == index
                                      ? Colors.blue
                                      : Colors.transparent),
                            ),
                            child: RadioListTile(
                              toggleable: true,
                              activeColor: Colors.blue,
                              value: index,
                              contentPadding: EdgeInsets.zero,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (questionController.choiceLanguage == "" ||
                                      questionController.choiceLanguage ==
                                          "English")
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        index == 0
                                            ? Text(data.lang2AnswerA.toString())
                                            : index == 1
                                                ? Text(data.lang2AnswerB
                                                    .toString())
                                                : index == 2
                                                    ? Text(data.lang2AnswerC
                                                        .toString())
                                                    : index == 3
                                                        ? Text(data.lang2AnswerD
                                                            .toString())
                                                        : Text(data.lang2AnswerE
                                                            .toString()),
                                      ],
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        index == 0
                                            ? Text(data.lang1AnswerA.toString())
                                            : index == 1
                                                ? Text(data.lang1AnswerB
                                                    .toString())
                                                : index == 2
                                                    ? Text(data.lang1AnswerC
                                                        .toString())
                                                    : index == 3
                                                        ? Text(data.lang1AnswerD
                                                            .toString())
                                                        : Text(data.lang1AnswerE
                                                            .toString()),
                                      ],
                                    )
                                ],
                              ),
                              groupValue: questionController.selectedVal,
                              onChanged: (value) {
                                setState(
                                  () {
                                    questionController.selectedVal = value;
                                    if (value == 0) {
                                      questionController.selectedAnswer.value =
                                          "A";
                                    } else if (value == 1) {
                                      questionController.selectedAnswer.value =
                                          "B";
                                    } else if (value == 2) {
                                      questionController.selectedAnswer.value =
                                          "C";
                                    } else if (value == 3) {
                                      questionController.selectedAnswer.value =
                                          "D";
                                    } else if (value == 4) {
                                      questionController.selectedAnswer.value =
                                          "E";
                                    }
                                    print("SelectedAnswer : ${questionController.selectedAnswer.value}");
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          SizedBox(height: 60)
        ],
      ),
    );
  }
}
