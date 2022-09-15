import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/utils/image_contants.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';

class ResetSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: size30, left: size20, right: size12),
            child: Image.asset(backButtonImage,
                height: size22, width: size22),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size20),
          child: ListView(
            children: [
              Container(
                height: size300,
                margin:
                EdgeInsets.symmetric(horizontal: size40, vertical: size30),
                child: Image.asset(resetPasswordBgImage),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    passwordResetSuccessfulText,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size80),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          yourAccountPasswordText,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          youCanLoginText,
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          passwordDotText,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    )),
              ),
              RoundedButton(
                text: goToLoginText,
                press: () {
                  Get.offAllNamed(ROUTE_LOGIN);
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
