import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/reset_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_password_field.dart';
import 'package:green_pen/utils/image_contants.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var resetController = Get.put(ResetController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding:  EdgeInsets.only(top: size30,left: size20,right: size12),
            child: Image.asset(backButtonImage,height: size22,width: size22),
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
                margin: EdgeInsets.symmetric(horizontal: size40,vertical: size30),
                child: Image.asset(resetIconBgImage),
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
                          resetText,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: size4),
                        child: Text(
                          passwordWithQuestionText,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
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
                    resetYourPasswordContextText,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              GetBuilder<ResetController>(
                  builder: (resetController) {
                  return RoundedPasswordField(
                    onChanged: (value) {},
                    controller: resetController.passController,
                    hint: newPasswordText,
                    press: () {
                      setState(() {
                        resetController.passwordVisible = !resetController.passwordVisible;
                      });
                    },
                    passwordVisible: resetController.passwordVisible,
                  );
                }
              ),
              GetBuilder<ResetController>(
                  builder: (resetController) {
                  return RoundedPasswordField(
                    onChanged: (value) {},
                    controller: resetController.confirmPassController,
                    hint: confirmNewPasswordText,
                    press: () {
                      setState(() {
                        resetController.cPasswordVisible = !resetController.cPasswordVisible;
                      });
                    },
                    passwordVisible: resetController.cPasswordVisible,
                  );
                }
              ),
              RoundedButton(
                text: submitText,
                press: () {
                  resetController.validation(context, resetController.passController.text, resetController.confirmPassController.text);
                }, color: secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
