import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/register_controller.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_input_field.dart';
import 'package:green_pen/screen/widgets/rounded_password_field.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_constant.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: registerController.scaffoldKey,
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size20),
                      child: Text(signupText,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: size200,
                      //width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: size40, vertical: size30),
                      child:
                          Image.asset('assets/png_file/signup_icon_logo.png'),
                    ),
                  ],
                ),
                GetBuilder<RegisterController>(builder: (registerController) {
                  return RoundedInputField(
                    hintText: firstNameText,
                    onChanged: (value) {},
                    controller: registerController.fNameController,
                  );
                }),
                GetBuilder<RegisterController>(builder: (registerController) {
                  return RoundedInputField(
                    hintText: lastNameText,
                    onChanged: (value) {},
                    controller: registerController.lNameController,
                  );
                }),
                GetBuilder<RegisterController>(builder: (registerController) {
                  return RoundedInputField(
                    hintText: emailIdText,
                    onChanged: (value) {},
                    controller: registerController.emailController,
                  );
                }),
                GetBuilder<RegisterController>(builder: (registerController) {
                  return RoundedInputField(
                    hintText: mobileNumberText,
                    onChanged: (value) {},
                    controller: registerController.phoneController,
                  );
                }),
                GetBuilder<RegisterController>(builder: (registerController) {
                  return RoundedPasswordField(
                    onChanged: (value) {},
                    controller: registerController.passwordController,
                    hint: passwordText,
                    press: () {
                      setState(() {
                        registerController.passwordVisible =
                            !registerController.passwordVisible;
                      });
                    },
                    passwordVisible: registerController.passwordVisible,
                  );
                }),
                SizedBox(
                  height: size10,
                ),
                Row(
                  children: [
                    Text(
                      signingUpText,
                      style: TextStyle(),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        termsAndConditionsText,
                        style: TextStyle(
                          color: Color(0xFF537EC0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      andText,
                      style: TextStyle(),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        privacyPolicyText,
                        style: TextStyle(
                          color: Color(0xFF537EC0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                RoundedButton(
                  text: signupText,
                  press: () async {
                    setState(
                      () {
                        registerController.validation(
                            context,
                            registerController.emailController.text,
                            registerController.fNameController.text,
                            registerController.lNameController.text,
                            registerController.phoneController.text,
                            registerController.passwordController.text);
                      },
                    );
                  },
                  color: secondaryColor,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(existingUserText,
                          style: TextStyle(fontSize: 16)),
                      TextButton(
                        child: Text(
                          loginText,
                          style:
                              TextStyle(color: Color(0xFF537EC0), fontSize: 16),
                        ),
                        onPressed: () {
                          Get.toNamed(ROUTE_LOGIN);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
