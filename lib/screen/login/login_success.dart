import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';

class LoginSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size20),
          child: ListView(
            children: [
              Container(
                height: size300,
                margin:
                     EdgeInsets.symmetric(horizontal: size40, vertical: size30),
                child: Image.asset('assets/png_file/reset_password.png'),
              ),
              Padding(
                padding:  EdgeInsets.only(bottom: size20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    verifiedSuccessfullyText,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size80),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      yourAccountSuccessfullyText,
                      style: TextStyle(fontSize: 14),
                    )),
              ),
              RoundedButton(
                text: doneText,
                press: () {
                  Get.offAllNamed(ROUTE_DASHBOARD);
                },
                color: secondaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
