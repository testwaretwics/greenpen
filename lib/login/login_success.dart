import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/dashboard/dashboard.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/widgets/rounded_button.dart';

class LoginSuccessScreen extends StatelessWidget {
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
                  alignment: Alignment.center,child: Text("Verified Successfully",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text("Your Account has been created successfully",
                      style: TextStyle(fontSize: 14 ),)
                ),
              ),

              RoundedButton(text: "Done", press: () {
                Get.offAll(()=>DashBoard());
              })
            ],
          ),
        ),
      ),
    );
  }
}
