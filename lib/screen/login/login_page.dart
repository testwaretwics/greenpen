import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/login_controller.dart';
import 'package:green_pen/screen/login/register_page.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_input_field.dart';
import 'package:green_pen/screen/widgets/rounded_password_field.dart';

import 'forgot_password.dart';
import 'otp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Image.asset('assets/png_file/login_icon_logo.png'),
            ),
            const Text('Login',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<LoginController>(
                builder: (loginController) {
                return RoundedInputField(
                  hintText: 'Email Id / Mobile Number',
                  onChanged: (value) {},
                  controller: loginController.emailController,
                );
              }
            ),
            GetBuilder<LoginController>(
                builder: (loginController) {
                return RoundedPasswordField(
                  onChanged: (value) {},
                  controller: loginController.passwordController,
                  hint: 'Password',
                  press: () {
                    setState(() {
                      loginController.passwordVisible = !loginController.passwordVisible;
                    });
                  },
                  passwordVisible: loginController.passwordVisible,
                );
              }
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.only(right: 35, left: 0, top: 0, bottom: 20),
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(ROUTE_FORGOT_PASSWORD);
                    },
                    child: const Text('Forget Password?',
                        style: TextStyle(
                          color: Color(0xFF537EC0),
                        ))),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: 'Login',
              press: () async {
                setState(() {
                  //Get.toNamed(ROUTE_OTP);
                   loginController.validation(context, loginController.emailController.text, loginController.passwordController.text);
                });
              }, color: secondaryColor,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User? ', style: TextStyle(fontSize: 16)),
                  TextButton(
                    child: const Text(
                      'Sign up',
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
