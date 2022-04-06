import 'package:flutter/material.dart';
import 'package:green_pen/utils/custColors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        backgroundColor: primaryLightColor,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Clear All",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "21-Mar-2022 , 6:00pm",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur ipiselit. Pellentesque tellus sapien id sapien. Cras rnare eget dui pretium vitae. "),
                  Divider()
                ],
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
