import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/pages/page.dart';
import 'package:green_pen/screen/assessments/assessments.dart';
import 'package:green_pen/screen/dashboard/dashboard.dart';
import 'package:green_pen/screen/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages
    );
  }
}
