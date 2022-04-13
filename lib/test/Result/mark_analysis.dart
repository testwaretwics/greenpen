import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/custColors.dart';

class MarkAnalysis extends StatelessWidget {
  const MarkAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mark Analysis"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Total Questions :  200",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 150,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      resultWidget(Color(0xff60B687), "Correct", "105"),
                      resultWidget(Color(0xffE30211), "Wrong", "15"),
                      resultWidget(Color(0xffEB996E), "Negative", "23"),
                      resultWidget(Color(0xffC7C7C7), "Unanswered", "04"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(child: Center(child: Text("data"))),
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
                onPressed: () {
                  // Get.to(() => TestReportPage());
                },
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
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    height: 305,
                    width: 320,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.8, color: Color(0xffD9D9D9))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(""),
                            Text(""),
                            Text(""),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 60,
                        width: 60,
                        color: primaryColor,
                        child: Center(
                            child: Text("01",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18))),
                      )),
                ],
              ),
            )
          ],
        )),
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
                  '⚈   ',
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
