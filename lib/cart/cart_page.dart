import 'package:flutter/material.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/widgets/rounded_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 20, left: 10, right: 10),
                child: Row(
                  children: [
                    Text(
                      "Test",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      "Add More to Cart",
                      style: TextStyle(
                          color: secondaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return testWidget();
                  },
                  itemCount: 2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 170,
                width: 320,
                decoration: BoxDecoration(color: Color(0xffF4F4F4)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Order Amount",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff666666),
                          ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "\u{20B9}  INR 3000 /-",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Tax",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff666666),
                          ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "\u{20B9}  INR 500 /-",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff666666),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                              fontSize: 16,
                              color: secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                              fontSize: 16,
                              color: secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\u{20B9}  INR 3000 /-",
                          style: TextStyle(
                              fontSize: 16,
                              color: secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FlatButton(
                  color: primaryColor,
                  height: 50,
                  minWidth: 140,
                  onPressed: () {
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pay Now",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container testWidget() {
    return Container(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Container(
                    height: 201,
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD9D9D9),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Text(
                            "General Tamil",
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Container(
                            height: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "GR- II & IIA Prelims General Studies",
                                  style: TextStyle(
                                      fontSize: 16, color: secondaryColor),
                                ),
                                Text(
                                  "+ English",
                                  style: TextStyle(
                                      fontSize: 16, color: secondaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Text(
                            "\u{20B9}   3000 /-",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff263238),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.collections_bookmark_outlined,
                                  color: Color(0xff263238),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Text(
                                  "MCQ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff263238),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.library_books,
                                  color: Color(0xff263238),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Text(
                                  "20 Tests",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff263238),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.computer_rounded,
                                  color: Color(0xff263238),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Text(
                                  "Online",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff263238),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  color: Color(0xff263238),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: Text(
                                  "23-Mar-2022",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff263238),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 115,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffFCBEB7),
                      ),
                      child: Center(
                        child: Text("01",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ))
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: Icon(Icons.cancel_rounded, color: Colors.black, size: 26))
        ],
      ),
    );
  }
}
