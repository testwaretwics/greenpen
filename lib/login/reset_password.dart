import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/widgets/rounded_button.dart';
import 'package:green_pen/widgets/rounded_input_field.dart';
import 'package:green_pen/widgets/rounded_password_field.dart';
import 'package:green_pen/widgets/text_field_container.dart';

import 'otp.dart';
import 'reset_success.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late bool passwordVisible;
  late bool cPasswordVisible;

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    cPasswordVisible = true;
  }

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> validation(
      BuildContext context, String pass, String confirmPass) async {
    if (!pass.isEmpty) {
      if (!confirmPass.isEmpty) {
        if (confirmPass == pass) {
          Get.to(() => ResetSuccessScreen());
        } else {
          Get.snackbar("", "Confirm Password should be same as New Password",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("", "Confirm Password should not be empty",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      Get.snackbar("", "New Password should not be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Don’t worry it happens, we will help you to reset your password. ",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              RoundedPasswordField(
                onChanged: (value) {},
                controller: _passController,
                hint: "New Password",
                press: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                passwordVisible: passwordVisible,
              ),
              RoundedPasswordField(
                onChanged: (value) {},
                controller: _confirmPassController,
                hint: "Confirm New Password",
                press: () {
                  setState(() {
                    cPasswordVisible = !cPasswordVisible;
                  });
                },
                passwordVisible: cPasswordVisible,
              ),
              RoundedButton(
                text: "Submit",
                press: () {
                  validation(context, _passController.text, _confirmPassController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
