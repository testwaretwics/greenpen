import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/test/Result/mark_analysis.dart';
import 'package:green_pen/utils/custColors.dart';

import 'data_report.dart';

class TestReportPage extends StatelessWidget {
  const TestReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Report"),
        centerTitle: true,
        backgroundColor: primaryLightColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.close))],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "TNPSC",
                style: TextStyle(color: primaryLightColor, fontSize: 14),
              ),
            ),
            Text(
              "GR- II & IIA Prelims General Studies",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              "+ English",
              style: TextStyle(fontSize: 16, color: Colors.black),
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
                    "90 minutes",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.menu_book,
                      size: 24,
                    ),
                  ),
                  Text("100 / 200 Marks")
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
                Text("Rank : 50")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
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
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(()=>MarkAnalysis());
                  },
                  child: Container(
                    height: 108,
                    width: 148,
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
                          color: Color(0xffFE9ECC),
                        ),
                        Spacer(),
                        Container(
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mark Analysis",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(()=>DataReports());
                  },
                  child: Container(
                    height: 108,
                    width: 148,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 10,
                          color: Color(0xff9EE7FE),
                        ),
                        Spacer(),
                        Container(
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Data Reports",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
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
