// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/notification_controller.dart';
import 'package:green_pen/utils/custColors.dart';

class NotificationsDetailPage extends StatelessWidget {
  NotificationsDetailPage({Key? key}) : super(key: key);
  var notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Detail"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Obx(
        () => notificationController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              notificationController
                                  .readNotificationData!.createdAt
                                  .toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              notificationController.readNotificationData!.title
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          HtmlWidget(
                            notificationController
                                .readNotificationData!.description
                                .toString(),
                            textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
