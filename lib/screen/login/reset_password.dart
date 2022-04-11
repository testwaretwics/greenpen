import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/reset_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_password_field.dart';
import 'reset_success.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var resetController = Get.put(ResetController());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            padding: const EdgeInsets.only(top: 30,left: 20),
            child: Image.asset('assets/png_file/back_arrow.png',height: 22,width: 22),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                child: Image.asset('assets/png_file/reset_icon_logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Password ?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      // can add more TextSpans here...
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Don’t worry it happens, we will help you to reset your password. ',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              GetBuilder<ResetController>(
                  builder: (resetController) {
                  return RoundedPasswordField(
                    onChanged: (value) {},
                    controller: resetController.passController,
                    hint: 'New Password',
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
                    hint: 'Confirm New Password',
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
                text: 'Submit',
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
