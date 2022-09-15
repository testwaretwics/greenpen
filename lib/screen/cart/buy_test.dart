// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/buy_test_controller.dart';
import 'package:green_pen/controller/cart_controller.dart';
import 'package:green_pen/controller/dashboard_controller.dart';
import 'package:green_pen/model/buy_test_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';

class BuyTestPage extends StatefulWidget {
  @override
  State<BuyTestPage> createState() => _BuyTestPageState();
}

class _BuyTestPageState extends State<BuyTestPage> {
  final buyTestController = Get.put(BuyTestController());
  final cartController = Get.put(CartController());
  var dashboardController = Get.put(DashboardController());

  RefreshController _refreshControllerForThis = RefreshController(initialRefresh: false);

  Future<void> _onRefresh() async{
    // monitor network fetch
    print("pull 1");
    await Future.delayed(Duration(milliseconds: 1000));
    print("pull 2");
    buyTestController.apiCallingMethod();
    print("pull 3");
    // if failed,use refreshFailed()
    dashboardController.refreshController.refreshCompleted();
    print("pull 4");
  }

  Future<void> _onLoading() async{
    // monitor network fetch
    print("pull 5");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    print("pull 6");
    print("pull 7");
    if(mounted) setState(() {});
    print("pull 8");
    dashboardController.refreshController.loadComplete();
    print("pull 9");
  }
  // void _onLoading() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   if (mounted) setState(() {});
  //   dashboardController.refreshController.loadComplete();
  // }




  var refreshKey = GlobalKey();

  @override
  void initState() {
    buyTestController.apiCallingMethod();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: GlobalKey(),
      appBar: AppBar(
        title: Text("Buy Test"),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        actions: [
          GetBuilder<CartController>(builder: (cartController) {
            return Showcase(
              key: buyTestController.four,
              title: 'Cart',
              overlayOpacity: 0.2,
              description: 'Click here to see cart',
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(ROUTE_CART);
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  cartController.cartDataList.isNotEmpty
                      ? Positioned(
                          right: 10,
                          top: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: secondaryColor),
                            child: Center(
                              child: Text(
                                cartController.cartDataList.length.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            );
          })
        ],
      ),
      body: Obx(
        () => buyTestController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                backgroundColor: primaryColor,
                strokeWidth: 1.5,
              ))
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15),
                Showcase(
                  key: buyTestController.five,
                  title: 'Category',
                  overlayOpacity: 0.2,
                  description: 'List of categories',
                  radius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30)),
                  child: CustomRadioButton(
                    defaultSelected: buyTestController.tabCategoryId,
                    unSelectedBorderColor: Colors.grey.shade200,
                    selectedBorderColor: Colors.grey.shade200,
                    enableShape: true,
                    // customShape: ShapeBorder().,
                    padding: 12,
                    spacing: 5,
                    elevation: 0,
                    absoluteZeroSpacing: false,
                    unSelectedColor: Theme.of(context).canvasColor,
                    buttonLables: List.generate(
                        buyTestController.categoryDataList.length,
                        (index) => buyTestController
                            .categoryDataList[index].courseCategoryLang1!),
                    buttonValues: List.generate(
                        buyTestController.categoryDataList.length,
                        (index) =>
                            buyTestController.categoryDataList[index].id!),
                    buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Color(0xffB5B5B5),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    radioButtonValue: (value) {
                      buyTestController.tabCategoryId = value;
                      buyTestController
                          .getCategoryWithPackageDetailDataList(value);
                    },
                    selectedColor: Color(0xff80B2FF),
                  ),
                ),
                SizedBox(height: 15),
                buyTestController.categoryWithPackageDetailDataList.isEmpty
                    ? Container(
                        height: size.height / 1.5,
                        alignment: AlignmentDirectional.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/png_file/no_data.png',
                                height: 153, width: 148),
                            const SizedBox(height: 15),
                            const Text(
                              'No Tests Scheduled',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'We will notify you once you get your \ntests scheduled.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                      child: SmartRefresher(
                  controller: _refreshControllerForThis,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                        key: refreshKey,
                        child: ListView.builder(
                           //shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                            itemCount: buyTestController.categoryWithPackageDetailDataList.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: examWidget(buyTestController.categoryWithPackageDetailDataList[index], index),
                                ),
                              );
                            },
                          ),
                      ),
                    ),
              ],
            ),
      ),
    );
  }

  Widget examWidget(
    PackageDetail data,
    int index,
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                children: [
                  Text(
                    data.languages.toString(),
                    style: TextStyle(
                      color: Color(0xff1CBBA3),
                    ),
                  ),
                  Spacer(),
                  data.cartStatus == "1"
                      ? Container(
                          width: 60,
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: secondaryColor,
                              ),
                              Text(
                                "Added",
                                style: TextStyle(
                                    color: secondaryColor, fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  data.orderStatus == 1
                      ? index == 1
                          ? Showcase(
                              key: buyTestController.seven,
                              title: 'Purchase',
                              overlayOpacity: 0.2,
                              description: 'Already purchase this test',
                              child: InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                    "assets/png_file/square_tick.png",
                                    height: 22,
                                    width: 22,
                                  )),
                            )
                          : InkWell(
                              onTap: () {},
                              child: Image.asset(
                                "assets/png_file/square_tick.png",
                                height: 22,
                                width: 22,
                              ))
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Container(
                child: Text(
                  data.packageNameLang1.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Text(
                "\u{20B9} INR ${data.feesForNew.toString()}/-",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff296ACC),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,

                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Image.asset(
                                      "assets/png_file/examtype.png",
                                      height: 22,
                                      width: 22,
                                    )),
                                Container(
                                  child: Text(
                                    data.examType.toString().toUpperCase(),
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
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Image.asset(
                                      "assets/png_file/online.png",
                                      height: 22,
                                      width: 22,
                                    )),
                                Container(
                                  child: Expanded(
                                    child: Text(
                                      data.packageType.toString(),
                                      //"Online , Offline",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff263238),
                                      ),
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(
                                  "assets/png_file/test.png",
                                  height: 22,
                                  width: 22,
                                )),
                            Container(
                              child: Text(
                                "${data.noOfTest.toString()} Tests",
                                //"20 Tests",
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
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.asset(
                                  "assets/png_file/date_range.png",
                                  height: 22,
                                  width: 22,
                                )),
                            Container(
                              child: Text(
                                data.startDate.toString(),
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
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      height: 50,
                      onPressed: () async {
                        var result = await (Connectivity().checkConnectivity());
                        if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                          Get.toNamed(ROUTE_ABOUT_TEST,
                              arguments: data.packageId);
                        } else {
                          Get.snackbar('Internet', 'No Internet Connection',
                              backgroundColor: Colors.red, colorText: Colors.white);
                        }

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "View Details",
                            style: TextStyle(color: primaryColor),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 2, color: primaryColor)),
                            child: Icon(
                              Icons.arrow_forward_sharp,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: primaryColor)),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: index == 0
                        ? Showcase(
                            key: buyTestController.six,
                            title: 'Book Now',
                            overlayOpacity: 0.2,
                            description: 'Click here to book now ',
                            radius: BorderRadius.circular(10),
                            child: FlatButton(
                              color: primaryColor,
                              height: 50,
                              onPressed: () {
                                Get.toNamed(ROUTE_BOOK_FORM, arguments: [
                                  data.packageId,
                                  data.feesForNew
                                ]);
                              },
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: primaryColor)),
                            ),
                          )
                        : FlatButton(
                            color: primaryColor,
                            height: 50,
                            onPressed: () {
                              print("cart ${data.cartStatus}");
                              print("order ${data.orderStatus}");
                              if (data.cartStatus == "1") {
                                Get.snackbar("", "",
                                    messageText: Center(
                                        child: Text(
                                      "This Package is already in cart",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                                    colorText: Colors.white,
                                    backgroundColor: Colors.blue,
                                    snackPosition: SnackPosition.BOTTOM);
                              } else if (data.orderStatus == 1) {
                                Get.snackbar("", "",
                                    messageText: Center(
                                        child: Text(
                                      "This Package is already purchased",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                                    colorText: Colors.white,
                                    backgroundColor: Colors.blue,
                                    snackPosition: SnackPosition.BOTTOM);
                              } else {
                                Get.toNamed(ROUTE_BOOK_FORM, arguments: [
                                  data.packageId,
                                  data.feesForNew
                                ]);
                              }
                            },
                            child: Text(
                              "Book Now",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: primaryColor)),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
