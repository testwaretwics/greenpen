import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/widgets/rounded_button.dart';
import '../buy/buy_test.dart';

class TestInstructions extends StatefulWidget {
  const TestInstructions({Key? key}) : super(key: key);

  @override
  _TestInstructionsState createState() => _TestInstructionsState();
}

class _TestInstructionsState extends State<TestInstructions> {
  bool isChecked = false;
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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 15.0, top: 10, bottom: 20, right: 10),
        child: ListView(
          children: [
            Text(
              "Exam Mode:Online\nMedium of Exam :English\nSubject: Full Test 5 prelims\nTopics Covered: Paper 2\nTotal Number of Questions :100 Questions\nMaximum Marks :100 Marks\nDuration of Examination:2 Hours\nEXAM Type : MCQ\nMarking Scheme: For each correct answer, the candidates\nwill be awarded 1 marks; if an answer is wrong,then 1\nmark will be deducted",
              style: TextStyle(fontSize: 14, letterSpacing: 0.4),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Before starting the exam:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              "1. Make sure your device (mobile/tab/laptop/desktop) is ready and at your disposal for appearing for the online exam.\n2. Make sure you have a good and stable internet connection.\n3. Make sure you join the Zoom room through student online portal, in the same way you join your regular online live classes, designated for the respective subject’s online exam, at least 15 minutes prior to the stipulated time of the actual exam.\n4. After joining the Zoom room, mark your attendance with the invigilators present in the room. If a student’s name doesn’t appear in the list of examinees shared by the invigilators to the exam cell, that student’s exam shall be considered ‘disqualified’ by the exam cell.\n5. Ensure your visibility to the invigilators by enabling the camera of your device (mobile/tab/laptop/desktop).\n6. Login to the online exam page (Student online portal > Student login > Dashboard > Online Test) 5 minutes prior to the stipulated time of the exam and wait for the invigilator’s instruction. Do not click on the START button until you are prompted by the invigilators to do so.\n7. Make sure you DO NOT open any other link/tab on your browser apart from the exam link during the online exam.\n8. Listen to all the instructions by invigilators carefully and comply with them meticulously",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (val) {
                      setState(() {
                        isChecked = val!;
                      });
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "I Agree to the terms and conditions of",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "the test",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    ? Get.to(() => BuyTestPage())
                    : Get.snackbar("", "agree the terms and conditions",
                        colorText: Colors.white, backgroundColor: Colors.blue);
              },
              color: primaryLightColor,
            )
          ],
        ),
      ),
    );
  }
}
