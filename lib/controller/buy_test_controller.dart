import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/model/multipleCQ_model.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class BuyTestController extends GetxController {
  // List<dynamic> ans = [].obs;

  void assign(val) {
    update();
  }

  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Widget examWidget(String name, double amount, bool isDone) {
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
                  name,
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
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FlatButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "View Detail",
                            style: TextStyle(color: primaryColor, fontSize: 16),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2, color: primaryColor)),
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Book Now",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
