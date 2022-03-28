import 'package:flutter/material.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/widgets/rounded_button.dart';

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool isVisible = true;
  bool _enable = false;
  late TextEditingController _fNameController;

  late final TextEditingController _lNameController;

  late final TextEditingController _emailController;

  late final TextEditingController _mobileController;

  late final TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fNameController = TextEditingController(text: "First Name");
    _lNameController = TextEditingController(text: "Last Name");
    _emailController = TextEditingController(text: "Email");
    _mobileController = TextEditingController(text: "Mobile Number");
    _passwordController = TextEditingController(text: "Password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: primaryLightColor,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _enable = !_enable;
                });
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 150,
                      color: primaryLightColor,
                    ),
                    Positioned(
                      top: 30,
                      left: 30,
                      child: Container(
                        child: ClipOval(child: Image.network("https://data.whicdn.com/images/322027365/original.jpg?t=1541703413",height: 90,width: 90,fit:BoxFit.cover)),
                      ),
                    ),
                    Positioned(
                      top: 75,
                      left: 90,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldWidget(_fNameController),
                textFieldWidget(_lNameController),
                textFieldWidget(_emailController),
                textFieldWidget(_mobileController),
                passwordFieldWidget(
                  onChanged: (value) {},
                  press: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  passwordVisible: isVisible,
                  controller: _passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, top:60),
                  child: RoundedButton(text: "Save", press: () {
                    print(_passwordController.text);
                  }),
                ),
              ],
            ),
            Positioned(
              top: 50,
              right: 60,
              child: Container(
                height: 150,
                width: 120,
                decoration: BoxDecoration(color: Colors.green),
                child: Icon(Icons.camera_alt_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding passwordFieldWidget(
      {required bool passwordVisible,
      required dynamic onChanged,
      required TextEditingController controller,
      required dynamic press, required }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
      child: TextFormField(
        obscureText: passwordVisible,
        onChanged: onChanged,
        controller: controller,
        cursorColor: primaryColor,
        enabled: _enable,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB5B5B5)),
          suffixIcon: IconButton(
            icon: Icon(
              !passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: press,
          ),
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Padding textFieldWidget(TextEditingController _controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          enabled: _enable,
          // icon: Icon(
          //   icon,
          //   color: primaryColor,
          // ),
          // hintText: hintText,
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}
