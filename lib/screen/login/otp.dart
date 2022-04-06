import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'login_success.dart';
import 'reset_password.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key, required this.name}) : super(key: key);
  final String name;
  // final otpController = Get.put(OtpController());
  final TextEditingController _otpTextController = TextEditingController();


  Future<void> validation(
      BuildContext context, String otp) async {
    if (!otp.isEmpty && otp.length ==4 && otp!='') {
      name =='forgot'? Get.to(() =>ResetPasswordScreen()): Get.offAll(()=>LoginSuccessScreen());
      } else {
        Get.snackbar('', 'Please enter valid OTP',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
  }


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
                margin: const EdgeInsets.only(left: 30,right: 30,bottom: 30),
                child: Image.asset('assets/png_file/otp_icon_logo.png'),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Enter OTP',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              mobileNumContent(context, size),
              Container(
                padding:
                    const EdgeInsets.only(top: 35, right: 25, left: 25, bottom: 10),
                child: AutofillGroup(
                  child: PinCodeTextField(
                    cursorColor: Colors.green,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 60,
                      fieldWidth: 65,
                      activeFillColor: const Color(0xFFF2F2F2),
                      errorBorderColor: const Color(0xFFF2F2F2),
                      disabledColor: const Color(0xFFF2F2F2),
                      selectedColor: const Color(0xFFF2F2F2),
                      activeColor: const Color(0xFFF2F2F2),
                      inactiveColor: const Color(0xFFF2F2F2),
                      inactiveFillColor: const Color(0xFFF2F2F2),
                      selectedFillColor: const Color(0xFFF2F2F2),
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    textStyle: const TextStyle(color: Colors.green),
                    controller: _otpTextController,
                    onCompleted: (val) {},
                    onChanged: (String value) {},
                    length: 4,
                    appContext: (context),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(fontSize: 14, color: secondaryColor),
                    ),
                    onPressed: () {},
                  )),
              const SizedBox(
                height: 10,
              ),
              RoundedButton(
                  text: 'Proceed',
                  press: () {
                    Get.toNamed(ROUTE_DASHBOARD);
                    //validation(context, _otpTextController.text);
                    // Get.to(() => name=="forgot"? ResetPasswordScreen(): LoginSuccessScreen());
                  }, color: secondaryColor,)
            ],
          ),
        ),
      ),
    );
  }

  Widget mobileNumContent(BuildContext context, Size size) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text.rich(
            TextSpan(
              text: 'A 4 digit code has been sent to ',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  // fontWeight: TextUtils.titleTextWeight,
                  // fontSize: 14.sp,
                  height: 1.5),
              children: <TextSpan>[
                const TextSpan(
                  text: ' +91' +
                      // controller.mobile!.substring(0, 0) +
                      '1234567890',
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .bodyText1!
                  //     .copyWith(
                  //         color: black,
                  //         fontWeight: TextUtils.titleTextWeight,
                  //         fontSize: 14.sp)
                ),

                // can add more TextSpans here...
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpEditText extends StatelessWidget {
  TextEditingController? textcontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textcontroller,
      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: Colors.transparent,
      autofocus: true,
      onChanged: (val) {},
      showCursor: false,
      readOnly: false,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        filled: true,
        hintText: '*',
        counterText: '',
        isDense: true,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(4),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.black, fontWeight: FontWeight.w900, fontSize: 14),

      // validator: (value) => value.trim().isEmpty ? 'Email required' : null,
    );
  }
}
