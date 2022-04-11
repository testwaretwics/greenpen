import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/forgot_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_input_field.dart';
import 'package:green_pen/screen/widgets/text_field_container.dart';

class ForgotPasswordScreen extends StatelessWidget {
   final forgotController = Get.put(ForgotController());

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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
             Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
              child: Image.asset('assets/png_file/forgot_password.png'),
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
                        'Forgot ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child:  Text(
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
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child:  Align(
                alignment: Alignment.center,
                child: Text(
                  'Don’t worry it happens, we will help you to reset your password. ',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            GetBuilder<ForgotController>(
                builder: (forgotController) {
                return TextFieldContainer(
                  child: RoundedInputField(
                    onChanged: (String value) {},
                    controller: forgotController.textController,
                    hintText: 'Email Id/ Mobile Number',
                  ),
                );
              }
            ),
            RoundedButton(
              text: 'Proceed',
              press: () {
                forgotController.validation(context, forgotController.textController.text);
              }, color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
