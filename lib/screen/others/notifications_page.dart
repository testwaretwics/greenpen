// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/notification_controller.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key? key}) : super(key: key);
  var notificationController = Get.put(NotificationController());

  clearAllNotificationDialog() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: "Are you sure ?",
      content: Text("You want to clear all notification."),
      actions: [
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xff296ACC),
            ),
          ),
          child: FlatButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: secondaryColor),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xff296ACC),
            ),
          ),
          child: FlatButton(
            color: secondaryColor,
            onPressed: () {
              Get.back();
              notificationController.getNotificationClearApiData();
            },
            child: Text(
              "Start Test",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              clearAllNotificationDialog();
            },
            child: Text(
              "Clear All",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Obx(
        () => notificationController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : notificationController.notificationDataList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/png_file/emptyTestTimeTableIcon.png',
                            height: 153,
                            width: 148),
                        const SizedBox(height: 15),
                        const Text(
                          'No Notification For You',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'We will notify you once you get any \nmessages.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount:
                          notificationController.notificationDataList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(ROUTE_NOTIFICATION_READ);
                                notificationController
                                    .getNotificationReadApiData(
                                        notificationController
                                            .notificationDataList[index].id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        notificationController
                                            .notificationDataList[index]
                                            .createdAt.toString(),
                                        style: TextStyle(color: secondaryColor),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    HtmlWidget(
                                      notificationController
                                          .notificationDataList[index]
                                          .description
                                          .toString(),
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
                            ),
                            notificationController
                                        .notificationDataList[index].status ==
                                    0
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 60, right: 10),
                                    child: CircleAvatar(
                                      backgroundColor: primaryColor,
                                      radius: 10,
                                      child: Text("1",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
