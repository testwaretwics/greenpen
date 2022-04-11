import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/dashboard_controller.dart';
import 'package:green_pen/screen/assessments/assessments.dart';
import 'package:green_pen/screen/dashboard/profile_Info_page.dart';
import 'package:green_pen/screen/home/home_page.dart';
import 'package:green_pen/screen/login/login_page.dart';
import 'package:green_pen/screen/others/help.dart';
import 'package:green_pen/screen/others/notifications_page.dart';
import 'package:green_pen/screen/others/privacy_policy.dart';
import 'package:green_pen/screen/others/terms&cond.dart';
import 'package:green_pen/utils/custColors.dart';


class DashBoard extends StatelessWidget {
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {

    List<BottomNavigationBarItem> itemBar = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: GetBuilder<DashboardController>(
          builder: (DashboardController dashboardController) {
          return Padding(
            padding:  const EdgeInsets.only(top: 0,bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/png_file/home.png',height: 20,width: 22,color: dashboardController.selectedIndex==0 ? kBlue1Color : kGreyColor),
                if (dashboardController.selectedIndex==0) Container(
                  height: 6,width: 6,
                  margin: const EdgeInsets.only(top: 7),
                  decoration: const BoxDecoration(
                      color: kBlue1Color,
                      shape: BoxShape.circle
                  ),
                ) else const SizedBox.shrink()
              ],
            )

          );
        }
      ), label: ''),
      BottomNavigationBarItem(
          icon: GetBuilder<DashboardController>(
          builder: (DashboardController dashboardController) {
          return Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart,size: 25,color: dashboardController.selectedIndex==1 ? kBlue1Color : kGreyColor),
                if (dashboardController.selectedIndex==1) Container(
                  height: 6,width: 6,
                  margin: const EdgeInsets.only(top: 7),
                  decoration: const BoxDecoration(
                      color: kBlue1Color,
                      shape: BoxShape.circle
                  ),
                ) else const SizedBox.shrink()
              ],
            )
          );
        }
      ), label: ''),
      BottomNavigationBarItem(
        icon: GetBuilder<DashboardController>(
        builder: (DashboardController dashboardController) {
        return Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pie_chart,size: 25,color: dashboardController.selectedIndex==2 ? kBlue1Color : kGreyColor),
              if (dashboardController.selectedIndex==2) Container(
                height: 6,width: 6,
                margin: const EdgeInsets.only(top: 7),
                decoration: const BoxDecoration(
                    color: kBlue1Color,
                    shape: BoxShape.circle
                ),
              ) else const SizedBox.shrink()
            ],
          ),
      );
            }
          ), label: ''),
      BottomNavigationBarItem(
        icon: GetBuilder<DashboardController>(
          builder: (DashboardController dashboardController) {
          return Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/png_file/edit_note.png',height: 22,width: 22,color: dashboardController.selectedIndex==3 ? kBlue1Color : kGreyColor),
                if (dashboardController.selectedIndex==3) Container(
                  height: 6,width: 6,
                  margin: const EdgeInsets.only(top: 7),
                  decoration: const BoxDecoration(
                      color: kBlue1Color,
                      shape: BoxShape.circle
                  ),
                ) else const SizedBox.shrink()
              ],
            ),
          );
        }
      ), label: ''),
    ];

    return Theme(
        data: ThemeData(primaryIconTheme: const IconThemeData(color: Colors.black)),
        child: GetBuilder<DashboardController>(
            builder: (DashboardController dashboardController) {
            return Scaffold(
              drawer: dashboardController.selectedIndex==0 ? drawerMenu() : null,
              body: IndexedStack(
                index: dashboardController.selectedIndex,
                children: [
                  const HomePage(),
                  Container(child: const Center(child: Text("2"))),
                  Container(child: const Center(child: Text("3"))),
                  const Assessments(),
                ],
              ),
              bottomNavigationBar: GetBuilder<DashboardController>(
                  builder: (DashboardController dashboardController) {
                  return BottomNavigationBar(
                    items: itemBar,selectedFontSize: 0,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: dashboardController.selectedIndex,
                    onTap: dashboardController.tabChange,
                  );
                }
              ),
            );
          }
        ),
      );
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
                color: const Color(0xff296ACC),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Abhirami Balamurugan',
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '+91-1234567890',
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              drawerMenuButtons(ProfileInfo(), 'My Profile'),
              drawerMenuButtons(ProfileInfo(), 'Purchased History'),
              drawerMenuButtons(const TermsAndConditions(), 'Terms & Conditions'),
              drawerMenuButtons(const PrivacyPolicy(), 'Privacy Policy'),
              drawerMenuButtons(const HelpPage(), 'Help'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: InkWell(
                  onTap: () {
                    Get.offAll(() => LoginPage(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            'assets/images/uil_signout.png',
                            color: const Color(0xff296ACC),
                            height: 30,
                            width: 30,
                          ),
                        ),
                        const Text(
                          'Sign Out',
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
                        'https://data.whicdn.com/images/322027365/original.jpg?t=1541703413',
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
                child: const Icon(Icons.close_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell drawerMenuButtons(Widget route, String name) {
    return InkWell(
      onTap: () {
        Get.to(() => route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(name)],
        ),
      ),
    );
  }

}
