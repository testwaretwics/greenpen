import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/widgets/rounded_button.dart';
import 'package:green_pen/widgets/rounded_input_field.dart';
import 'package:green_pen/widgets/text_field_container.dart';

import 'otp.dart';

class ForgotPasswordScreen extends StatelessWidget {
  // OtpScreen({Key? key}) : super(key: key);
  // final otpController = Get.put(OtpController());
  final TextEditingController _textController = TextEditingController();

  Future<void> validation(BuildContext context, String userId) async {
    if (!userId.isEmpty) {
      Get.to(
        () => OtpScreen(
          name: 'forgot',
        ),
      );
    } else {
      Get.snackbar("", "Please enter Email Id or Mobile Number",
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
                          'Forgot ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          'Password ? ',
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
              TextFieldContainer(
                child: RoundedInputField(
                  onChanged: (String value) {},
                  controller: _textController,
                  hintText: 'Email Id/ Mobile Number',
                ),
              ),
              RoundedButton(
                text: "Proceed",
                press: () {
                  validation(context, _textController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
