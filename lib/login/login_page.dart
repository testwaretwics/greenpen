import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/login/register_page.dart';
import 'package:green_pen/widgets/rounded_button.dart';
import 'package:green_pen/widgets/rounded_input_field.dart';
import 'package:green_pen/widgets/rounded_password_field.dart';

import 'forgot_password.dart';
import 'otp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> validation(
      BuildContext context, String emailValue, String passwordValue) async {
    if (!emailValue.isEmpty) {
      /* if (!regExp.hasMatch(emailValue)) {*/
      if (!passwordValue.isEmpty) {
        // apiService = new APIService();
        // isApiCallProcess = true;
        // apiService.loginUserAPI(emailValue, passwordValue).then((value) => resultAPI(context,value)

        // );
        Get.to(() => OtpScreen(name: 'login',));
      } else {
        Get.snackbar("", "Please Enter Password",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      /* } else {
          snakbarMsg(context, Icons.person, "Please Enter Proper Email",
              Colors.red, Colors.white);
        }*/
    } else {
      Get.snackbar("", "Please Enter Email",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

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
            ),
            Text("Login",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            RoundedInputField(
              hintText: "Email Id / Mobile Number",
              onChanged: (value) {},
              controller: emailController,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              controller: passwordController,
              hint: "Password",
              press: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              passwordVisible: passwordVisible,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 35, left: 0, top: 0, bottom: 20),
                child: TextButton(
                    onPressed: () {
                      Get.to(() => ForgotPasswordScreen());
                    },
                    child: Text('Forget Password?',
                        style: TextStyle(
                          color: Color(0xFF537EC0),
                        ))),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Login",
              press: () async {
                setState(() {
                  validation(
                      context, emailController.text, passwordController.text);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New User? ", style: TextStyle(fontSize: 16)),
                  TextButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Color(0xFF537EC0), fontSize: 16),
                    ),
                    onPressed: () {
                      Get.to(() => RegisterPage());
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
