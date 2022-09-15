import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/notification/PushNotificationService.dart';
import 'package:green_pen/screen/dashboard/dashboard.dart';
import 'package:green_pen/screen/splash/splash_screen.dart';
import 'package:showcaseview/showcaseview.dart';
import 'pages/page.dart';
import 'utils/preferences.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.instance.getToken().then((value) => {
     print("token id :- $value")
  });
  await PushNotificationService().setupInteractedMessage();
  HttpOverrides.global =  MyHttpOverrides();

  runApp(
    ShowCaseWidget(
      autoPlay: false,
      autoPlayDelay: Duration(seconds: 8),
      autoPlayLockEnable: false,
      builder: Builder(
        builder: (context) => MyApp(),
      ),
      onStart: (index, key) {
        print('onStart: $index, $key');
      },
      onComplete: (index, key) {
        print('onComplete: $index, $key');
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages
    );
  }
}
