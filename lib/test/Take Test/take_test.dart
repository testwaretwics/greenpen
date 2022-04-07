import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/buy_test_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'about_test_page.dart';

class TakeTestPage extends StatelessWidget {
  final _controller = Get.put(BuyTestController());
  final String amount = "INR 3000/-";
  final bool isDone = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey(),
      appBar: AppBar(
        title: Text("Take Test"),
        centerTitle: true,
        backgroundColor: primaryLightColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            CustomRadioButton(
              defaultSelected: 1,
              enableShape: true,
              unSelectedBorderColor: Colors.grey.shade200,
              selectedBorderColor: Colors.grey.shade200,
              // customShape: ShapeBorder().,
              padding: 10,
              spacing: 5,
              elevation: 0,
              absoluteZeroSpacing: false,
              unSelectedColor: Theme.of(context).canvasColor,
              buttonLables: [
                'TNPSC',
                'UPSC',
                'TNUSRB',
              ],
              buttonValues: [
                1,
                2,
                3,
              ],
              buttonTextStyle: ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Color(0xffB5B5B5),
                textStyle: TextStyle(fontSize: 16),
              ),
              radioButtonValue: (value) {},
              selectedColor: Color(0xff80B2FF),
            ),
            SizedBox(height: 20),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: examWidget(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container examWidget() {
    return Container(
        height: 260,
        width: 340,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    "General Tamil",
                    style: TextStyle(
                      color: Color(0xff1CBBA3),
                    ),
                  ),
                  Spacer(),
                  isDone
                      ? InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.library_add_check,
                            color: Color(0xff1CBBA3),
                          ),
                        )
                      : Container(),
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
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      "+ English",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "\u{20B9}   $amount",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff296ACC),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Icon(
                      FontAwesomeIcons.calendar,
                      color: Color(0xff263238),
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Text(
                      "Start Date : ",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff263238),
                      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Expanded(
                child: FlatButton(
                  color: Colors.white,
                  height: 50,
                  onPressed: () {
                    Get.to(() => AboutTestStatus());
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        "View Details",
                        style: TextStyle(color: primaryColor),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: primaryColor)),
                        child: Icon(
                          Icons.arrow_forward_sharp,
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: primaryColor)),
                ),
              ),
            )
          ],
        ),);
  }
}
