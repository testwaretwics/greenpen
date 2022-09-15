import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/utils/style_size.dart';
import 'package:green_pen/utils/text_utils.dart';

SnackBar? snackBarMsg({IconData? icon,var title, var msg, Color? bgColor, Color? colors}) {
  Get.snackbar(
    title,
    msg,
    icon: Icon(icon,color: colors,size: size28,),
    shouldIconPulse: false,
    barBlur: 50,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    padding: EdgeInsets.all(size10),
    snackPosition: SnackPosition.TOP,
    backgroundColor: bgColor,
    borderRadius: size10,
    titleText: Text(title,style: TextStyle(
        color: colors,
        fontFamily: TextUtils.interFontFamily,
        fontSize: size16 / Get.textScaleFactor,
        fontWeight: FontWeight.bold),),
    messageText: Text(msg,style: TextStyle( fontFamily: TextUtils.interFontFamily,
      color: colors,
      fontSize: size16 / Get.textScaleFactor,),),
    //dismissDirection: SnackDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeOutBack,

  );
}




SnackBar? snackBarNotificationMsg({var title, var msg, Color? bgColor, Color? titleColors,Color? messageColor}) {
  Get.snackbar(
    title, // title
    msg, // message
    icon: Image.asset('assets/images/ic_launcher.png',),
    shouldIconPulse: false,
    barBlur: 50,
    isDismissible: true,
    duration: const Duration(seconds: 3),
    padding:const EdgeInsets.all(20),
    snackPosition: SnackPosition.TOP,
    backgroundColor: bgColor,
    borderRadius: 10,
    titleText: Text(title,style: TextStyle(color: titleColors,fontSize: size16 / Get.textScaleFactor,fontWeight: FontWeight.bold),),
    messageText: Text(msg,style: TextStyle(color: messageColor),),
  );
}