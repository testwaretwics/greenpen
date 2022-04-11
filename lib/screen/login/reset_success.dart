import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';

import 'login_page.dart';

class ResetSuccessScreen extends StatelessWidget {
  // OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                child: Image.asset('assets/png_file/reset_password.png'),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child:
                Align(
                  alignment: Alignment.center,child: Text('Password Reset Successful',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Your Account password has been created',
                          style: TextStyle(fontSize: 14 ),),
                        Text('successfully. You can login with your new',
                          style: TextStyle(fontSize: 14 ),),
                        Text('password.',
                          style: TextStyle(fontSize: 14 ),),
                      ],
                    )
                ),
              ),

              RoundedButton(text: 'Go to Login', press: () {
                Get.offAllNamed(ROUTE_LOGIN);
              }, color: secondaryColor,)
            ],
          ),
        ),
      ),
    );
  }
}
