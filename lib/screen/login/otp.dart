// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/otp_controller.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';
import 'package:green_pen/utils/text_utils.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: size30, left: size20, right: size12),
            child: Image.asset('assets/png_file/back_arrow.png',
                height: size22, width: size22),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size20),
          child: ListView(
            children: [
              Container(
                height: size300,
                margin: EdgeInsets.only(left: size30, right: size30, bottom: size30),
                child: Image.asset('assets/png_file/otp_icon_logo.png'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size20),
                child: Text(
                  enterOTPText,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              mobileNumContent(context, size),
              SizedBox(
                height: size30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size60,
                    width: size65,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: OtpEditText(
                          textController: controller.firstTextController,
                          focusNode: controller.firstTextFocusNode,
                          editable: true,
                          onChanged: (value) {
                            controller.firstTextController.text.isNotEmpty
                                ? FocusScope.of(context).nextFocus()
                                : FocusScope.of(context).unfocus();
                          },
                        )),
                  ),
                  SizedBox(
                    width: size22,
                  ),
                  Container(
                    height: size60,
                    width: size65,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: OtpEditText(
                          textController: controller.secondTextController,
                          editable: true,
                          onChanged: (value) {
                            controller.secondTextController.text.isNotEmpty
                                ? FocusScope.of(context).nextFocus()
                                : FocusScope.of(context).previousFocus();
                          },
                        )),
                  ),
                  SizedBox(
                    width: size22,
                  ),
                  Container(
                    height: size60,
                    width: size65,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: OtpEditText(
                          textController: controller.thirdTextController,
                          editable: true,
                          onChanged: (value) {
                            controller.thirdTextController.text.isNotEmpty
                                ? FocusScope.of(context).nextFocus()
                                : FocusScope.of(context).previousFocus();
                          },
                        )),
                  ),
                   SizedBox(
                    width: size22,
                  ),
                  Container(
                    height: size60,
                    width: size65,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: OtpEditText(
                          textController: controller.fourthTextController,
                          editable: true,
                          onChanged: (value) {
                            controller.fourthTextController.text.isNotEmpty
                                ? FocusScope.of(context).unfocus()
                                : FocusScope.of(context).previousFocus();
                          },
                        )),
                  ),
                ],
              ),
              SizedBox(height: size10),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      resendOTPText,
                      style: TextStyle(fontSize: 14, color: secondaryColor),
                    ),
                    onPressed: () {},
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: size70,
        margin: EdgeInsets.only(left: size20, right: size20),
        child: RoundedButton(
          text: proceedText,
          press: () {
            controller.otpValidation();
          },
          color: secondaryColor,
        ),
      ),
    );
  }

  Widget mobileNumContent(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.only(left: size4),
      child: Text.rich(
        TextSpan(
          text: digitCodeText,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: TextUtils.titleTextWeight, fontSize: 14, height: 1.5),
          children: <TextSpan>[
            TextSpan(
              text: ' +91' + controller.userMobile.toString(),
            ),

            // can add more TextSpans here...
          ],
        ),
      ),
    );
  }
}

class OtpEditText extends StatelessWidget {
  TextEditingController? textController;
  final ValueChanged<String>? onChanged;
  final bool? editable;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function? onEditingComplete;
  OtpEditText(
      {Key? key,
      this.textController,
      this.onChanged,
      this.editable,
      this.focusNode,
      this.textInputAction,
      this.onEditingComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      builder: (controller) => TextFormField(
        controller: textController,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: Colors.green,
        autofocus: true,
        onEditingComplete: () => onEditingComplete,
        onChanged: onChanged,
        // showCursor: false,
        readOnly: false,
        enabled: editable,
        focusNode: focusNode,
        textInputAction: textInputAction,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.grey.withOpacity(0.2),
          hintText: '',
          counterText: "",
          // isDense: true,
          border: InputBorder.none,
          hintStyle: TextStyle(
              fontFamily: TextUtils.interFontFamily,
              fontWeight: TextUtils.normalTextWeight,
              fontSize: 19 / Get.textScaleFactor),
        ),
        style: TextStyle(
            fontFamily: TextUtils.interFontFamily,
            fontWeight: TextUtils.normalTextWeight,
            fontSize: 19 / Get.textScaleFactor,
            color: Colors.green),
      ),
    );
  }
}
