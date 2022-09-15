import 'dart:async';
import 'package:flutter/material.dart';
import 'package:green_pen/screen/dashboard/dashboard.dart';
import 'package:green_pen/screen/login/login_page.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Preferences.getBoolValuesSF(Preferences.USER_EXIST) == null ||
            Preferences.getBoolValuesSF(Preferences.USER_EXIST) == false
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()))
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: splashScreenColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Align(
                alignment: Alignment.topCenter,
                heightFactor: 8.0,
                child: Image.asset("assets/png_file/greenpen.png")),
            Positioned(
                bottom: size.width * 0.04,
                child: Container(
                    height: size.height * 0.53,
                    width: size.width * 0.8,
                    child: Image.asset(
                      "assets/png_file/plash_screen_image.png",
                      fit: BoxFit.fill,
                    ))),
          ],
        ),
      ),
    );
  }
}
