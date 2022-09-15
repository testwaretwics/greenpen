import 'package:flutter/material.dart';
import 'package:green_pen/utils/custColors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final dynamic press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FlatButton(
          splashColor: primaryLightColor,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          color: color,
          onPressed: press,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
