import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/register_controller.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/screen/widgets/rounded_button.dart';
import 'package:green_pen/screen/widgets/rounded_input_field.dart';
import 'package:green_pen/screen/widgets/rounded_password_field.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("Sign Up",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 200,
                    //width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                    child: Image.asset('assets/png_file/signup_icon_logo.png'),
                  ),
                ],
              ),

              GetBuilder<RegisterController>(
                builder: (registerController) {
                  return RoundedInputField(
                    hintText: "First Name",
                    onChanged: (value) {},
                    controller: registerController.fNameController,
                  );
                }
              ),
              GetBuilder<RegisterController>(
                  builder: (registerController) {
                  return RoundedInputField(
                    hintText: "Last Name",
                    onChanged: (value) {},
                    controller: registerController.lNameController,
                  );
                }
              ),
              GetBuilder<RegisterController>(
                  builder: (registerController) {
                  return RoundedInputField(
                    hintText: "Email Id",
                    onChanged: (value) {},
                    controller: registerController.emailController,
                  );
                }
              ),
              GetBuilder<RegisterController>(
                  builder: (registerController) {
                  return RoundedInputField(
                    hintText: "Mobile Number",
                    onChanged: (value) {},
                    controller: registerController.phoneController,
                  );
                }
              ),
              GetBuilder<RegisterController>(
                  builder: (registerController) {
                  return RoundedPasswordField(
                    onChanged: (value) {},
                    controller: registerController.passwordController,
                    hint: "Password",
                    press: () {
                      setState(() {
                        registerController.passwordVisible = !registerController.passwordVisible;
                      });
                    },
                    passwordVisible: registerController.passwordVisible,
                  );
                }
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'By signing up, you agree to our ',
                    style:  TextStyle(
                      // color: Color(0xFF537EC0),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color:  Color(0xFF537EC0),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'and ',
                    style:  TextStyle(
                      // color: Color(0xFF537EC0),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Privacy Policy',
                      style:  TextStyle(
                        color: Color(0xFF537EC0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Sign Up",
                press: () async {
                  setState(
                        () {
                      registerController.validation(context, registerController.emailController.text, registerController.fNameController.text, registerController.lNameController.text, registerController.phoneController.text,
                          registerController.passwordController.text);
                    },
                  );
                }, color: secondaryColor,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Existing User ? ", style: TextStyle(fontSize: 16)),
                    TextButton(
                      child: const Text(
                        "Login",
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
      )
    );
  }
}
