import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/dashboard/profile_Info_page.dart';
import 'package:green_pen/others/help.dart';
import 'package:green_pen/others/privacy_policy.dart';
import 'package:green_pen/others/terms&cond.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.black)),
      child: Scaffold(
        drawer: Drawer(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Color(0xff296ACC),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Abhirami Balamurugan",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "+91-1234567890",
                            style: TextStyle(
                                letterSpacing: 1,
                                color: Colors.white,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  drawerMenuButtons(ProfileInfo(), "My Profile"),
                  drawerMenuButtons(ProfileInfo(), "Purchased History"),
                  drawerMenuButtons(TermsAndConditions(), "Terms & Conditions"),
                  drawerMenuButtons(PrivacyPolicy(), "Privacy Policy"),
                  drawerMenuButtons(HelpPage(), "Help"),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => ProfileInfo(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Color(0xff296ACC),
                              ),
                            ),
                            Text(
                              "Sign Out",
                              style: TextStyle(
                                color: Color(0xff296ACC),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 130,
                left: 30,
                child: ClipOval(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.white,
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 10,
                child: Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Icon(Icons.close_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: Column(
            children: [
              Spacer(),
              AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notification_important_rounded,
                            color: Colors.black,
                          ),
                        ),
                        Positioned(
                          right: 13,
                          top: 6,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                color: Color(0xff1CBBA3),
                                shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => ProfileInfo(),
                        );
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => LoginPage()));
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  )
                ],
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text("Hi, ",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Text(
                      "Abhirami",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Last Login: ",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                    Text(
                      "16-Mar-2022",
                      style: TextStyle(
                          color: Color(0xff296ACC),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                Container(
                  height: 176,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-0.5, 0),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: Color(0xffAAE0FF),
                                  ),
                                  Text(
                                    "Ranks Scored Recently",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                  "Start Writing your Test and practise for your exams. "),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff1CBBA3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 32,
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Take Test",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(Icons.arrow_forward_rounded,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        width: 110,
                        child: Center(
                          child: Text("k"),
                        ),
                      ),
                    ],
                  ),
                ),
                Text("Summary for Tests ",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 97,
                            width: 147,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell drawerMenuButtons(Widget route, String name) {
    return InkWell(
      onTap: () {
        Get.to(() => route);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(name)],
        ),
      ),
    );
  }
}
