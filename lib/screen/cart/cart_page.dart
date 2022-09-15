// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/buy_test_controller.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/model/cart_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var cartController = Get.put(CartController());
  final buyTestController = Get.put(BuyTestController());

  Razorpay? _razorpay;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay!.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse paymentSuccessResponse) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Success ${paymentSuccessResponse.paymentId}"),
      duration: Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _handlePaymentError(PaymentFailureResponse paymentFailureResponse) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Errors ${paymentFailureResponse.message}"),
      duration: Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse externalWalletResponse) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("External Wallet ${externalWalletResponse.walletName}"),
      duration: Duration(seconds: 10),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_NNbwJ9tmM0fbxj',
      //'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': '120',
      'name': 'Test',
      'description': 'Payment',
      'prefill': {'contact': '1234554321', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['Paytm']
      },
      'theme': {'color': '#ffbf00'},
      //'order_id': '10'
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      print(e);
    }
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    cartController.getCartApiData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: primaryColor,
        leading: IconButton(onPressed: (){
          if(cartController.backButton){
            Get.back();
            Get.back();
          }else {
            Get.back();
          }
          buyTestController.apiCallingMethod();
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Obx(() =>
            cartController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : cartController.cartDataList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                            'assets/png_file/emptyTestTimeTableIcon.png',
                            height: 153,
                            width: 148),
                        const SizedBox(height: 15),
                        const Text(
                          'No Cart For You',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'We will notify you once you get your \ncart.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                : SmartRefresher(
              controller: _refreshController,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20, left: 10, right: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "${cartController.cartDataList.length} Test",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      if(cartController.backButton){
                                        Get.back();
                                        Get.back();
                                      }else {
                                        Get.back();
                                      }
                                      buyTestController.apiCallingMethod();
                                    },
                                    child: Text(
                                      "Add More to Cart",
                                      style: TextStyle(
                                          color: secondaryColor,
                                          decoration: TextDecoration.underline,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return testWidget(context,
                                      cartController.cartDataList[index], index);
                                },
                                itemCount: cartController.cartDataList.length,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        "\u{20B9}  INR ${cartController.orderAmount.value.round()} /-",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        "\u{20B9}  INR ${cartController.tax.value.round()} /-",
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        "\u{20B9}  INR ${cartController.totalAmount.value.round()} /-",
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
                              child: InkWell(
                                onTap: () async {
                                  setState(() {});
                                  var result = await (Connectivity().checkConnectivity());
                                  if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                                    openCheckout();
                                  } else {
                                    Get.snackbar('Internet', 'No Internet Connection',
                                        backgroundColor: Colors.red, colorText: Colors.white);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Pay Now",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
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
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                ),
      ),
    );
  }

  Widget testWidget(
    context,
    Cart cartDataList,
    int index,
  ) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Stack(
              children: [
                Container(
                    height: 201,
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
                            cartDataList.languages.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Container(
                            child: Text(
                              cartDataList.packageNameLang1.toString(),
                              //"GR- II & IIA Prelims General Studies + English",
                              style: TextStyle(
                                  fontSize: 16, color: secondaryColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Text(
                            "\u{20B9}   ${double.parse(cartDataList.price.toString()).round().toString()} /-",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff263238),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Image.asset(
                                                "assets/png_file/examtype.png",
                                                height: 22,
                                                width: 22,
                                              )),
                                          Container(
                                            child: Text(
                                              cartDataList.examType.toString(),
                                              //"MCQ",
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Image.asset(
                                                "assets/png_file/online.png",
                                                height: 22,
                                                width: 22,
                                              )),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            child: Text(
                                              cartDataList.packageType
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff263238),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              Spacer(),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Image.asset(
                                                "assets/png_file/test.png",
                                                height: 22,
                                                width: 22,
                                              )),
                                          Container(
                                            child: Text(
                                              "${cartDataList.noOfTest.toString()} Tests",
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Row(children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Image.asset(
                                              "assets/png_file/date_range.png",
                                              height: 22,
                                              width: 22,
                                            )),
                                        Container(
                                          child: Text(
                                            cartDataList.startDate.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff263238),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    )
                                  ])
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
                        color: primaryColor,
                      ),
                      child: Center(
                        child: Text("0${index + 1}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    )),
              ],
            ),
          ),
        ),
        Positioned(
            right: -11,
            top: -11,
            child: IconButton(
              icon: Icon(
                Icons.cancel_rounded,
                color: Colors.black,
                size: 26,
              ),
              onPressed: () async {
                var result = await (Connectivity().checkConnectivity());
                if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                  cartController.getRemoveCartApiData(cartDataList.id);
                } else {
                  Get.snackbar('Internet', 'No Internet Connection',
                      backgroundColor: Colors.red, colorText: Colors.white);
                }

              },
            ))
      ],
    );
  }
}
