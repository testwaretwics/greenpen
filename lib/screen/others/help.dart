// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/help_controller.dart';
import 'package:green_pen/utils/custColors.dart';

class HelpPage extends StatelessWidget {
  HelpPage({Key? key}) : super(key: key);
  var helpController = Get.put(HelpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Obx(
        () => helpController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HtmlWidget(
                      helpController.message.value,
                      textStyle: TextStyle(letterSpacing: 0.5, fontSize: 16),
                    ),
                  ],
                )),
              ),
      ),
    );
  }
}
