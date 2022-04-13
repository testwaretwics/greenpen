import 'package:flutter/material.dart';

class DataReports extends StatelessWidget {
  const DataReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Reports"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Text(""),
            ],
          )),
    );
  }
}
