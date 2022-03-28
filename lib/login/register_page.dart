import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/login/login_page.dart';
import 'package:green_pen/widgets/rounded_button.dart';
import 'package:green_pen/widgets/rounded_input_field.dart';
import 'package:green_pen/widgets/rounded_password_field.dart';

import 'otp.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> validation(BuildContext context, String emailValue, String fName,
      String lName, String mobileNum, String passwordValue) async {
    if (!fName.isEmpty) {
      if (!lName.isEmpty) {
        if (!emailValue.isEmpty) {
          if (!mobileNum.isEmpty) {
            /* if (!regExp.hasMatch(emailValue)) {*/
            if (!passwordValue.isEmpty) {
              // apiService = new APIService();
              // isApiCallProcess = true;
              // apiService.loginUserAPI(emailValue, passwordValue).then((value) => resultAPI(context,value)

              // );
              Get.to(() => OtpScreen(name: 'register',));

            } else {
              Get.snackbar("", "Please Enter Password",
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          } else {
            Get.snackbar("", "Please Enter Mobile Number",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        } else {
          Get.snackbar("", "Please Enter Email Id",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("", "Please Enter Last Name",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
    /* } else {
          snakbarMsg(context, Icons.person, "Please Enter Proper Email",
              Colors.red, Colors.white);
        }*/
    else {
      Get.snackbar("", "Please Enter First Name",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
              ),
              Text("Sign Up",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              RoundedInputField(
                hintText: "First Name",
                onChanged: (value) {},
                controller: fNameController,
              ),
              RoundedInputField(
                hintText: "Last Name",
                onChanged: (value) {},
                controller: lNameController,
              ),
              RoundedInputField(
                hintText: "Email Id",
                onChanged: (value) {},
                controller: emailController,
              ),
              RoundedInputField(
                hintText: "Mobile Number",
                onChanged: (value) {},
                controller: phoneController,
              ),
              RoundedPasswordField(
                onChanged: (value) {},
                controller: passwordController,
                hint: "Password",
                press: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                passwordVisible: passwordVisible,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'By signing up, you agree to our ',
                    style: TextStyle(
                        // color: Color(0xFF537EC0),
                        ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Terms & Conditions',
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
                    'and ',
                    style: TextStyle(
                        // color: Color(0xFF537EC0),
                        ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
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
                      validation(context, emailController.text, fNameController.text, lNameController.text, phoneController.text,
                          passwordController.text);
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Existing User ? ", style: TextStyle(fontSize: 16)),
                    TextButton(
                      child: Text(
                        "Login",
                        style:
                            TextStyle(color: Color(0xFF537EC0), fontSize: 16),
                      ),
                      onPressed: () {
                        Get.to(()=>LoginPage());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
