import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/forgot_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_input_field.dart';
import 'package:green_pen/screen/widgets/text_field_container.dart';
import 'package:green_pen/utils/image_contants.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final forgotController = Get.put(ForgotController());

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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: size20),
          children: [
            Container(
              height: size300,
              margin: EdgeInsets.symmetric(horizontal: size40, vertical: size30),
              child: Image.asset(forgotPasswordBgImage),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size4),
                      child: Text(
                        forgotText,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: size4),
                      child: Text(
                        passwordWithQuestionText,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: size26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  resetYourPasswordText,
                  style: TextStyle(fontSize: size14),
                ),
              ),
            ),
            GetBuilder<ForgotController>(builder: (forgotController) {
              return TextFieldContainer(
                child: RoundedInputField(
                  onChanged: (String value) {},
                  controller: forgotController.textController,
                  hintText: emailAndMobileText,
                ),
              );
            }),
            RoundedButton(
              text: proceedText,
              press: () {
                forgotController.validation(
                    context, forgotController.textController.text);
              },
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
