import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/login/login_page.dart';

import 'dashboard/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
