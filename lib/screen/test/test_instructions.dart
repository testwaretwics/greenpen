// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/test_instructions_controller.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class TestInstructions extends StatefulWidget {
  TestInstructions({Key? key}) : super(key: key);

  @override
  _TestInstructionsState createState() => _TestInstructionsState();
}

class _TestInstructionsState extends State<TestInstructions> {
  final testInstructionsController = Get.put(TestInstructionsController());


  bool isChecked = false;
 // double per = 1.0;


  @override
  void initState() {
    // TODO: implement initState
    configLoading();
    testInstructionsController.loadingPercentage.value = 0.1;

  //  if(testInstructionsController.isLoading.value) EasyLoading.showProgress(0.50, status: '${testInstructionsController.loadingPercentage.value}' );

    Timer.periodic(const Duration(milliseconds: 300), (Timer timer) {
          EasyLoading.showProgress(testInstructionsController.loadingPercentage.value,
              status: '${(testInstructionsController.loadingPercentage.value * 100).toStringAsFixed(0)}%');
          testInstructionsController.loadingPercentage.value += 0.015;

          if (testInstructionsController.loadingPercentage.value >= 1 && testInstructionsController.isLoading.value) {
            EasyLoading.dismiss();
           timer.cancel();

            Timer.periodic(Duration(milliseconds: 220), (timer2) {
              EasyLoading.showProgress(1.0,status: "Success",maskType: EasyLoadingMaskType.clear);
              if(!testInstructionsController.isLoading.value) {
                print("testInstructionsController.isLoading.value ${testInstructionsController.isLoading.value}");
                timer2.cancel();
                EasyLoading.dismiss();
              };
            });
          }

          if (testInstructionsController.loadingPercentage.value <= 1 && !testInstructionsController.isLoading.value) {
            EasyLoading.dismiss();
            timer.cancel();
            Timer.periodic(Duration(milliseconds: 220), (timer3) {
              EasyLoading.showProgress(1.0,status: "Success",maskType: EasyLoadingMaskType.clear);
              if(!testInstructionsController.isLoading.value) {
                print("testInstructionsController.isLoading.value ${testInstructionsController.isLoading.value}");
                timer3.cancel();
                Future.delayed(Duration(milliseconds: 1000),(){
                  EasyLoading.dismiss();
                });
              };
            });

          }

          if(!testInstructionsController.isLoading.value) {
            print("testInstructionsController.isLoading.value ${testInstructionsController.isLoading.value}");
            timer.cancel();
            EasyLoading.dismiss();
          };

        });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "General Instructions",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: FlutterEasyLoading(
        child: Obx(
          () => testInstructionsController.isLoading.value
              ?  Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 156.0),
                    // CircularPercentIndicator(
                    //   radius: 60.0,
                    //   lineWidth: 10.0,
                    //   percent: testInstructionsController.loadingPercentage.value,
                    //   center: Text("${testInstructionsController.loadingPercentage.value} %"),
                    //   backgroundColor: Colors.grey,
                    //   progressColor: Colors.blue,
                    // ),
                  ))
              : Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 20, right: 10),
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    children: [
                      HtmlWidget(
                        testInstructionsController.instruction.value,
                        textStyle: TextStyle(letterSpacing: 0.5, fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: isChecked,
                              activeColor: primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  if (testInstructionsController
                                          .instruction.value !=
                                      "") {
                                    isChecked = val!;
                                  } else {
                                    Get.snackbar("Instruction",
                                        "No question so you can't check",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                });
                              }),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "I Agree to the terms and conditions of",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "the test",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RoundedButton(
                        text: "Start Test",
                        press: () {
                          isChecked
                              ? Get.offAndToNamed(ROUTE_TEST_PAGE)
                              : Get.snackbar(
                                  "Instruction", "agree the terms and conditions",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.blue);
                        },
                        color: primaryLightColor,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // exitSubmitTestDialog() {
  //   Get.defaultDialog(
  //     titlePadding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
  //     contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
  //     title: "Are you sure ?",
  //     content: Text("You want to hold the test."),
  //     actions: [
  //       Container(
  //         height: 40,
  //         width: 120,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(5),
  //           border: Border.all(
  //             color: Color(0xff296ACC),
  //           ),
  //         ),
  //         child: FlatButton(
  //           onPressed: () {
  //             Get.back();
  //             Get.back();
  //           },
  //           child: Text(
  //             "Cancel",
  //             style: TextStyle(color: secondaryColor),
  //           ),
  //         ),
  //       ),
  //       Container(
  //         height: 40,
  //         width: 120,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(5),
  //           border: Border.all(
  //             color: Color(0xff296ACC),
  //           ),
  //         ),
  //         child: FlatButton(
  //           color: secondaryColor,
  //           onPressed: () {
  //             Get.back();
  //             Get.toNamed(ROUTE_TEST_PAGE);
  //           },
  //           child: Text(
  //             "Start Test",
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
