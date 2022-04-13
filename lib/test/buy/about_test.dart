import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/custColors.dart';

import 'test_syllabus.dart';

class AboutTest extends StatelessWidget {
  const AboutTest({Key? key}) : super(key: key);
  final String amount = "3000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Test"),
        centerTitle: true,
        backgroundColor: primaryLightColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      "Test Features",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FlatButton(color: Color(0xff296ACC),
                        height: 40,minWidth: 70,
                        onPressed: (){}, child: Text("Book Now"),textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                      ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "GR- II & IIA Prelims General Studies",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xff296ACC),
                        ),
                      ),
                      Text(
                        "+ English",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.collections_bookmark_outlined,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "MCQ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff263238),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.library_books,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "20 Tests",
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.computer_rounded,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "Online , Offline",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff263238),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xff263238),
                      ),
                    ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "\u{20B9} ",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "$amount /-",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff263238),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        FontAwesomeIcons.globe,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "Tamil",
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
                  Get.to(()=>TestSyllabus());
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
                padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                    child: testDetailWidget(),
                  );
                },
                itemCount: 5,),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container testDetailWidget() {
    return Container(
      height: 110,
      width: 372,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Row(
        children: [
          Container(
            width: 60,
            color: Color(0xff1CBBA3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "01",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            width: 290,
            height: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Text(
                        "Indian Polity",
                        style:
                            TextStyle(color: Color(0xff1CBBA3), fontSize: 18),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.lock_open)
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.timer,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Text(
                        "90 mins",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff263238),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.library_books,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "100 Questions",
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
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xff263238),
                      ),
                    ),
                    Container(
                      width: 120,
                      child: Text(
                        "23-Mar-2022",
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
    );
  }
}
