import 'package:flutter/material.dart';
import 'package:green_pen/utils/custColors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
        centerTitle: true,
        backgroundColor: primaryLightColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: Align(alignment: Alignment.centerLeft,child: Text("Lorem Ipsum",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                ),
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis metus, volutpat, molestie eget eu. Tristique scelerisque interdum leo venenatis augue in aliquet. Fermentum tortor nunc faucibus ut. Laoreet a, ut sed magna nec. Ipsum, nisi, eros, aliquet morbi amet velit pellentesque netus. Habitasse fermentum odio pretium placerat eget tincidunt. Facilisis aliquet sit vestibulum nam lectus porttitor tristique. Magnis mattis risus, pretium nibh eu viverra felis viverra. Ut nunc sollicitudin ultricies ut. Velit ullamcorper duis velit sed ultricies non egestas pharetra. Integer non cursus tincidunt sed faucibus elit eu at. ",
                    style: TextStyle(letterSpacing: 0.5, fontSize: 16)),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(alignment: Alignment.centerLeft,child: Text("Lorem Ipsum",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                ),
                Text("Tincidunt adipiscing auctor dui lectus in et nec eros sed. Nec, ridiculus lacus nullam scelerisque turpis. Suspendisse feugiat duis ante rutrum consequat, metus nulla tortor. Bibendum tempus diam ut fringilla facilisis. In nibh vestibulum aliquam sed facilisi rhoncus laoreet laoreet. At blandit risus urna quisque montes. Morbi lectus amet tellus bibendum metus nunc dignissim pharetra vitae. Et ut commodo nisl, viverra odio turpis lorem. In nec nisl, elit id mauris sagittis tellus iaculis. Congue at nulla enim vitae. Sit eget sapien aliquam mattis ultricies semper magna.Tincidunt adipiscing auctor dui lectus in et nec eros sed. Nec, ridiculus lacus nullam scelerisque turpis. Suspendisse feugiat duis ante rutrum consequat, metus ",style: TextStyle(letterSpacing: 0.5, fontSize: 16))
              ],
            )),
      ),
    );
  }
}
