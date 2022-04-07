import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:green_pen/assesment_page.dart';
import 'package:green_pen/dashboard/profile_Info_page.dart';
import 'package:green_pen/login/login_page.dart';
import 'package:green_pen/others/help.dart';
import 'package:green_pen/others/notifications_page.dart';
import 'package:green_pen/others/privacy_policy.dart';
import 'package:green_pen/others/terms&cond.dart';
import 'package:green_pen/test/Take%20Test/take_test.dart';
import 'package:green_pen/test/test_instructions.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GridVal {
  final IconData icon;
  final Color color;
  final String title;
  final String count;

  GridVal(this.icon, this.color, this.title, this.count);
}

class DashBoard extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final List<GridVal> gridVal = [
    GridVal(Icons.fact_check_outlined, Color(0xff4BB0C7), "Test Attended", "0"),
    GridVal(Icons.check_box, Color(0xff8EEAC9), "Test Completed", "0"),
    GridVal(
        Icons.pending_actions_outlined, Color(0xff8382DB), "Test Pending", "0"),
    GridVal(Icons.bookmark_sharp, Color(0xffB916A7), "Test Percentage", "0%")
  ];

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(4, (index) => demoCard());
    return Theme(
      data: ThemeData(primaryIconTheme: IconThemeData(color: Colors.black)),
      child: Scaffold(
        drawer: drawerMenu(),
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
                          onPressed: () {
                            Get.to(() => NotificationsPage());
                          },
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
                      child: ClipOval(
                          child: Image.network(
                              "https://data.whicdn.com/images/322027365/original.jpg?t=1541703413",
                              height: 50,
                              width: 50,
                              fit: BoxFit.fill)),
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
          child: SingleChildScrollView(
            child: Column(
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
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 15,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                mainCard(),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Summary for Tests ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 3),
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(5),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return gridChildren(
                          gridVal[index].icon,
                          gridVal[index].color,
                          gridVal[index].title,
                          gridVal[index].count);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  color: Color(0xffE4EDFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Test Timetable",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "16-Mar-2022",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff296ACC),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                testListWidget(),
                testListWidget(),
                testListWidget(),
                Stack(
                  children: [
                    SizedBox(
                      height: 176,
                      width: 350,
                      child: PageView.builder(
                        controller: controller,
                        // itemCount: pages.length,
                        itemBuilder: (_, index) {
                          return pages[index % pages.length];
                        },
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          type: WormType.thin,
                          // strokeWidth: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding testListWidget() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          child: ListTile(
            title: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.list_alt_outlined),
                Text("Descriptive"),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.timer),
                Text("90 mins"),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(()=>TakeTestPage());
                  },
                  child: Container(
                    height: 32,
                    width: 100,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Text(
                            "Take Test",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Drawer drawerMenu() {
    return Drawer(
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
                padding: const EdgeInsets.only(bottom: 60.0),
                child: InkWell(
                  onTap: () {
                    Get.offAll(
                      () => LoginPage(),
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
                          child: Image.asset(
                            "assets/images/uil_signout.png",
                            color: Color(0xff296ACC),
                            height: 30,
                            width: 30,
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
                child: ClipOval(
                    child: Image.network(
                        "https://data.whicdn.com/images/322027365/original.jpg?t=1541703413",
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill)),
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
    );
  }

  Container mainCard() {
    return Container(
      height: 176,
      width: 370,
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
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                    onTap: () {
                      Get.to(()=>TestInstructions());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1CBBA3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 32,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            width: 110,
            // child: Center(
            //   child: Text("k"),
            // ),
          ),
        ],
      ),
    );
  }

  Container demoCard() {
    return Container(
      height: 176,
      width: 370,
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
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            width: 110,
            // child: Center(
            //   child: Text("k"),
            // ),
          ),
        ],
      ),
    );
  }

  Padding gridChildren(IconData icon, Color color, String title, String count) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xffBCE4FB),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(icon, color: Colors.white),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              count,
              style: TextStyle(fontSize: 22),
            ),
          ],
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
