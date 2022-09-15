// ignore_for_file: deprecated_member_use

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pen/controller/take_test_controller.dart';
import 'package:green_pen/controller/take_test_detail_controller.dart';
import 'package:green_pen/model/take_test_model.dart';
import 'package:green_pen/utils/constant.dart';
import 'package:green_pen/utils/custColors.dart';
import 'package:green_pen/utils/preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showcaseview/showcaseview.dart';
import 'about_test_page.dart';

class TakeTestPage extends StatefulWidget {
  @override
  State<TakeTestPage> createState() => _TakeTestPageState();
}

class _TakeTestPageState extends State<TakeTestPage> {
  final takeTestController = Get.put(TakeTestController());


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  var refreshKey = GlobalKey();

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await Get.put(TakeTestController()).takeTestApiData();
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
  void initState() {
    takeTestController.getApiCallingMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: GlobalKey(),
      appBar: AppBar(
        title: Text("Take Test"),
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Obx(
        () => takeTestController.isLoading.value
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
                CustomRadioButton(
                  defaultSelected: takeTestController.tabCategoryId,
                  enableShape: true,
                  unSelectedBorderColor: Colors.grey.shade200,
                  selectedBorderColor: Colors.grey.shade200,
                  padding: 12,
                  spacing: 5,
                  elevation: 0,
                  absoluteZeroSpacing: false,
                  unSelectedColor: Theme.of(context).canvasColor,
                  buttonLables: List.generate(
                      takeTestController.categoryDataList.length,
                      (index) => takeTestController
                          .categoryDataList[index].courseCategoryLang1!),
                  buttonValues: List.generate(
                      takeTestController.categoryDataList.length,
                      (index) =>
                          takeTestController.categoryDataList[index].id!),
                  buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Color(0xffB5B5B5),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  radioButtonValue: (value) {
                    takeTestController.tabCategoryId = value;
                    takeTestController
                        .getCategoryWithOrderDetailDataList(value);
                  },
                  selectedColor: Color(0xff80B2FF),
                ),
                SizedBox(height: 15),
                takeTestController.categoryWithOrderDataList.isEmpty
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
                        key: refreshKey,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                        child: ListView.builder(
                            // shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: takeTestController.categoryWithOrderDataList.length,
                            itemBuilder: (context, index) {
                              return Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: examWidget(
                                      takeTestController
                                          .categoryWithOrderDataList[index],
                                      index),
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

  Container examWidget(
    Order orderDataList,
    int index,
  ) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  orderDataList.languages.toString(),
                  style: TextStyle(
                    color: Color(0xff1CBBA3),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 40,
              width: 270,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderDataList.packageNameLang1.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      "assets/png_file/examtype.png",
                      width: 22,
                      height: 22,
                    )),
                Container(
                  width: 120,
                  child: Text(
                    orderDataList.examType.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff263238),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      "assets/png_file/test.png",
                      width: 22,
                      height: 22,
                    )),
                Container(
                  width: 120,
                  child: Text(
                    "${orderDataList.noOfTest.toString()} Tests",
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
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      "assets/png_file/date_range.png",
                      width: 22,
                      height: 22,
                    )),
                Container(
                  //width: 90,
                  child: Text(
                    "Start Date : ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff263238),
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  child: Text(
                    orderDataList.startDate.toString(),
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: index == 0
                ? Showcase(
                    key: takeTestController.ten,
                    title: 'View Details',
                    overlayOpacity: 0.2,
                    description: 'Click here to see view details',
                    child: FlatButton(
                      color: Colors.white,
                      height: 50,
                      onPressed: () async {
                        var result = await (Connectivity().checkConnectivity());
                        if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                          Get.toNamed(ROUTE_ABOUT_TEST_STATUS);
                          Get.put(TakeTestDetailController()).getApiDataCalling(orderDataList.id);
                          Preferences.addDataToSF(Preferences.ORDER_DATA_ID, orderDataList.id);
                        } else {
                          Get.snackbar('Internet', 'No Internet Connection',
                              backgroundColor: Colors.red, colorText: Colors.white);
                        }

                      },
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "View Details",
                            style: TextStyle(color: primaryColor),
                          ),
                          SizedBox(
                            width: 10,
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
                          Spacer()
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: primaryColor)),
                    ),
                  )
                : FlatButton(
                    color: Colors.white,
                    height: 50,
                    onPressed: () async {
                      var result = await (Connectivity().checkConnectivity());
                      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
                        Get.toNamed(ROUTE_ABOUT_TEST_STATUS);
                        Get.put(TakeTestDetailController()).getApiDataCalling(orderDataList.id);
                        Preferences.addDataToSF(Preferences.ORDER_DATA_ID, orderDataList.id);
                      } else {
                        Get.snackbar('Internet', 'No Internet Connection',
                            backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    },
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          "View Details",
                          style: TextStyle(color: primaryColor),
                        ),
                        SizedBox(
                          width: 10,
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
                        Spacer()
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: primaryColor)),
                  ),
          )
        ],
      ),
    );
  }
}
