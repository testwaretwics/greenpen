import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/service/network_info.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_input_field.dart';
import 'package:green_pen/screen/widgets/rounded_password_field.dart';
import 'package:green_pen/utils/image_contants.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: loginController.scaffoldKey,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: size10, horizontal: size15),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: size400,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: size30),
              child: Image.asset(loginBgImage),
            ),
            Text(loginText,
                style: TextStyle(fontSize: size22, fontWeight: FontWeight.bold)),
            SizedBox(
              height: size20,
            ),
            GetBuilder<LoginController>(builder: (loginController) {
              return RoundedInputField(
                hintText: emailAndMobileText,
                onChanged: (value) {},
                controller: loginController.emailController,
              );
            }),
            GetBuilder<LoginController>(builder: (loginController) {
              return RoundedPasswordField(
                onChanged: (value) {},
                controller: loginController.passwordController,
                hint: passwordText,
                press: () {
                  setState(() {
                    loginController.passwordVisible =
                        !loginController.passwordVisible;
                  });
                },
                passwordVisible: loginController.passwordVisible,
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(bottom: size20),
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(ROUTE_FORGOT_PASSWORD);
                    },
                    child: Text(forgotPasswordText,
                        style: TextStyle(
                          color: Color(0xFF06006B),
                        ))),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            GetBuilder<LoginController>(builder: (loginController) {
              return RoundedButton(
                text: loginText,
                press: () async {
                  setState(() {
                    loginController.validation(
                        context,
                        loginController.emailController.text,
                        loginController.passwordController.text);
                  });
                },
                color: secondaryColor,
              );
            }),
            Padding(
              padding: EdgeInsets.only(bottom: size30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(newUserText, style: TextStyle(fontSize: size16)),
                  TextButton(
                    child: Text(
                      signupText,
                      style: TextStyle(color: Color(0xFF537EC0), fontSize: 16),
                    ),
                    onPressed: () {
                      Get.toNamed(ROUTE_REGISTER);
                    },
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
