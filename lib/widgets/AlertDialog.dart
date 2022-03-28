import 'package:flutter/material.dart';
import 'package:green_pen/utils/custColors.dart';

class AlertDialogSheet extends StatelessWidget {

  final String text;
  final Function press;
  final Color color, textColor;
  const AlertDialogSheet({
    Key? key,
    required this.text,
    required this.press,
    this.color = primaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        

      ),
    );
  }
}
