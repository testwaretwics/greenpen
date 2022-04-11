import 'package:flutter/material.dart';
import 'package:green_pen/utils/custColors.dart';

import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final dynamic press;
  final String hint;
  final bool passwordVisible;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.press,
    required this.hint,
    required this.passwordVisible
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: passwordVisible,
        onChanged: onChanged,
        controller: controller,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize:16,color:Color(0xFFB5B5B5)),
          // icon: Icon(
          //   Icons.lock,
          //   color: primaryColor,
          // ),
          suffixIcon: IconButton(
           icon: Icon(
             !passwordVisible
                 ? Icons.visibility
                 : Icons.visibility_off,
              color: Colors.grey,
            ),
onPressed: press,
          ),
          border: UnderlineInputBorder(),
        ),

      ),

    );
  }
}

