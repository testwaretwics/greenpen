import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/widgets/rounded_button.dart';

import 'login_page.dart';

class ResetSuccessScreen extends StatelessWidget {
  // OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                child:
                Align(
                  alignment: Alignment.center,child: Text("Password Reset Successful",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Account password has been created",
                          style: TextStyle(fontSize: 14 ),),
                        Text("successfully. You can login with your new",
                          style: TextStyle(fontSize: 14 ),),
                        Text("password.",
                          style: TextStyle(fontSize: 14 ),),
                      ],
                    )
                ),
              ),

              RoundedButton(text: "Go to Login", press: () {
                Get.offAll(()=>LoginPage());
              })
            ],
          ),
        ),
      ),
    );
  }
}
