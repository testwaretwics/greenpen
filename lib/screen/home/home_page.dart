import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/home_controller.dart';
import 'package:green_pen/screen/dashboard/profile_Info_page.dart';
import 'package:green_pen/screen/login/login_page.dart';
import 'package:green_pen/screen/others/help.dart';
import 'package:green_pen/screen/others/notifications_page.dart';
import 'package:green_pen/screen/others/privacy_policy.dart';
import 'package:green_pen/screen/others/terms&cond.dart';
import 'package:green_pen/test/test_instructions.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeController = Get.put(HomeController());

  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  final List<GridVal> gridVal = [
    GridVal(Icons.fact_check_outlined, const Color(0xff4BB0C7), 'Test Attended', '0'),
    GridVal(Icons.check_box, const Color(0xff8EEAC9), 'Test Completed', '0'),
    GridVal(
        Icons.pending_actions_outlined, const Color(0xff8382DB), 'Test Pending', '0'),
    GridVal(Icons.bookmark_sharp, const Color(0xffB916A7), 'Test Percentage', '0%')
  ];

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(4, (index) => demoCard());
    return Obx(()=> Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 80),
          child: Column(
            children: [
              const Spacer(),
              AppBar(
                leading: Builder(builder: (context) => // Ensure Scaffold is in context
                IconButton(
                    icon: Image.asset('assets/png_file/eva_menu.png',height: 28),
                    onPressed: () => Scaffold.of(context).openDrawer()
                ),),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.to(() => const NotificationsPage());
                          },
                          icon: const Icon(
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
                            decoration: const BoxDecoration(
                                color: Color(0xff1CBBA3),
                                shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ProfileInfo(),);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => LoginPage()));
                      },
                      child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            homeController.homeDataList.isNotEmpty ?
                            homeController.userImage.value :
                            'https://data.whicdn.com/images/322027365/original.jpg?t=1541703413',
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
        body: homeController.isLoading.value ?
            const Center(child: CircularProgressIndicator(backgroundColor: primaryColor,strokeWidth: 1.5,))    :
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children:   [
                      const Text('Hi, ',
                          style:  TextStyle(
                            fontSize: 18,
                          )),
                      Text(
                        homeController.homeDataList.isNotEmpty ?
                        homeController.userName.value : '',
                        //'Abhirami',
                        style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children:  [
                      const Text('Last Login: ',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      Text(
                        homeController.homeDataList.isNotEmpty ?
                        homeController.userLastLogin.value : '',
                        //'16-Mar-2022',
                        style: const TextStyle(
                            color: Color(0xff296ACC),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  mainCard(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Summary for Tests ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.7),
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        gridChildren(Icons.fact_check_outlined, const Color(0xff4BB0C7), 'Test Attended',
                            homeController.summaryForTestDataList.incompletedTest.toString()),
                        gridChildren(Icons.check_box, const Color(0xff8EEAC9), 'Test Completed',
                            homeController.summaryForTestDataList.completedTest.toString()),
                        gridChildren(Icons.pending_actions_outlined, const Color(0xff8382DB), 'Test Pending',
                            homeController.summaryForTestDataList.pendingTest.toString()),
                        gridChildren(Icons.bookmark_sharp, const Color(0xffB916A7), 'Test Percentage',
                            '${homeController.summaryForTestDataList.percentage.toString()}%')
                      ],
                    ),
                  ),
                  // Container(
                  //   child: GridView.builder(
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       childAspectRatio: MediaQuery.of(context).size.width /
                  //           (MediaQuery.of(context).size.height / 2.7),
                  //     ),
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     padding: const EdgeInsets.all(5),
                  //     itemCount: 4,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return gridChildren(
                  //           gridVal[index].icon,
                  //           gridVal[index].color,
                  //           gridVal[index].title,
                  //           homeController.homeDataList[0].summaryForTest!.completedTest.toString());
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    color: const Color(0xffE4EDFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'Test Timetable',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          '16-Mar-2022',
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
                          effect: const WormEffect(
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
            title: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.list_alt_outlined),
                const Text('Descriptive'),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.timer),
                const Text('90 mins'),
                const Spacer(),
                InkWell(
                  onTap: () {},
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
                          child: const Text(
                            'Take Test',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Container mainCard() {
    return Container(
      height: 176,
      width: 370,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
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
                    children: const [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xffAAE0FF),
                      ),
                      Text(
                        'Ranks Scored Recently',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                      'Start Writing your Test and practise for your exams. '),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(()=>const TestInstructions());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff1CBBA3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 32,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            'Take Test',
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
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
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
        boxShadow: const [
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
                    children: const [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Color(0xffAAE0FF),
                      ),
                      Text(
                        'Ranks Scored Recently',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                      'Start Writing your Test and practise for your exams. '),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff1CBBA3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      height: 32,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Text(
                            'Take Test',
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
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
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
            color: const Color(0xffBCE4FB),
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
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              count,
              style: const TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }

}

class GridVal {
  final IconData icon;
  final Color color;
  final String title;
  final String count;

  GridVal(this.icon, this.color, this.title, this.count);
}
